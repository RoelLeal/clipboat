import AppKit
import SwiftUI
import Combine

enum ClipItem: Identifiable {
    case text(String)
    case link(URL)
    case image(NSImage, Int)

    var id: String {
        switch self {
        case .text(let s):      return "t:\(s)"
        case .link(let u):      return "l:\(u.absoluteString)"
        case .image(_, let h):  return "i:\(h)"
        }
    }

    func matches(_ other: ClipItem) -> Bool {
        switch (self, other) {
        case (.text(let a),  .text(let b)):  return a == b
        case (.link(let a),  .link(let b)):  return a == b
        case (.image(_, let a), .image(_, let b)): return a == b
        default: return false
        }
    }
}

class ClipboardMonitor: ObservableObject {
    @Published var copiedItems: [ClipItem] = []

    private var timer: Timer?
    private var lastChangeCount: Int
    private let pasteboard = NSPasteboard.general
    private let maxItems = 20

    init() {
        lastChangeCount = pasteboard.changeCount
        startMonitoring()
    }

    func startMonitoring() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(checkClipboard),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func checkClipboard() {
        guard pasteboard.changeCount != lastChangeCount else { return }
        lastChangeCount = pasteboard.changeCount

        guard let item = readCurrentItem() else { return }

        DispatchQueue.main.async {
            if !self.copiedItems.contains(where: { $0.matches(item) }) {
                self.copiedItems.insert(item, at: 0)
                if self.copiedItems.count > self.maxItems {
                    self.copiedItems.removeLast()
                }
            }
        }
    }

    private func readCurrentItem() -> ClipItem? {
        // 1. Image
        if let data = pasteboard.data(forType: .tiff) ?? pasteboard.data(forType: .png),
           let image = NSImage(data: data) {
            return .image(image, data.hashValue)
        }

        // 2. URL (from .URL type or plain string that is a valid http/https URL)
        if let urls = pasteboard.readObjects(forClasses: [NSURL.self]) as? [URL],
           let url = urls.first,
           url.scheme == "https" || url.scheme == "http" {
            return .link(url)
        }

        if let text = pasteboard.string(forType: .string) {
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimmed.contains(" "),
               !trimmed.contains("\n"),
               let url = URL(string: trimmed),
               url.scheme == "https" || url.scheme == "http" {
                return .link(url)
            }

            // 3. Plain text
            if !trimmed.isEmpty {
                return .text(text)
            }
        }

        return nil
    }

    func removeItem(_ item: ClipItem) {
        copiedItems.removeAll { $0.matches(item) }
    }

    func copyToClipboard(_ item: ClipItem) {
        pasteboard.clearContents()
        switch item {
        case .text(let s):
            pasteboard.setString(s, forType: .string)
        case .link(let url):
            pasteboard.writeObjects([url as NSURL])
            pasteboard.setString(url.absoluteString, forType: .string)
        case .image(let img, _):
            if let tiff = img.tiffRepresentation {
                pasteboard.setData(tiff, forType: .tiff)
            }
        }
    }
}
