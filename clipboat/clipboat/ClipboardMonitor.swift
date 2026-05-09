import AppKit
import SwiftUI
internal import Combine

class ClipboardMonitor: ObservableObject {
    
    @Published var copiedItems: [String] = []
    
    private var timer: Timer?
    private var lastCounted: Int = 0
    
    private var pasteBoard = NSPasteboard.general
    
    
    init() {
        // Inicializamos con el conteo actual para no copiar lo que ya estaba antes de abrir la app
        self.lastCounted = pasteBoard.changeCount
        startMonitoring()
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkClipboard), userInfo: nil, repeats: true)
    }
    
    @objc func checkClipboard() {
        if pasteBoard.changeCount != lastCounted {
            lastCounted = pasteBoard.changeCount
            
            if let newItem = pasteBoard.string(forType: .string) {
                if !copiedItems.contains(newItem) {
                    DispatchQueue.main.async {
                        self.copiedItems.insert(newItem, at: 0)
                        if self.copiedItems.count > 10 {
                            self.copiedItems.removeLast()
                        }
                    }
                }
            }
        }
    }
    
    func copyToClipboard(item: String) {
        pasteBoard.clearContents()
        pasteBoard.setString(item, forType: .string)
    }
}
