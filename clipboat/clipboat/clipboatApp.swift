import SwiftUI

@main
struct ClipboatApp: App {
    @StateObject private var clipboardMonitor = ClipboardMonitor()

    var body: some Scene {
        MenuBarExtra("Clipboat", systemImage: "doc.on.clipboard") {
            VStack(spacing: 0) {
                HStack {
                    Text("Clipboat")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        clipboardMonitor.copiedItems.removeAll()
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                    .help("Clear History")
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                
                Divider()
                
                Group {
                    if clipboardMonitor.copiedItems.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.system(size: 32))
                                .foregroundColor(.secondary.opacity(0.5))
                            Text("No history")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                    } else {
                        ScrollView {
                            VStack(spacing: 4) {
                                ForEach(clipboardMonitor.copiedItems, id: \.self) { item in
                                    ClipboardItemView(item: item) {
                                        clipboardMonitor.copyToClipboard(item: item)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                        }
                        .frame(maxHeight: 350)
                    }
                }
                
                Divider()
                
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button("Quit") {
                        NSApplication.shared.terminate(nil)
                    }
                    .keyboardShortcut("q")
                    .buttonStyle(.plain)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
            }
            .frame(width: 320)
        }
        .menuBarExtraStyle(.window)
    }
}

struct ClipboardItemView: View {
    let item: String
    let action: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(isHovered ? .blue : .secondary)
                    .font(.system(size: 14))
                
                Text(item.prefix(80) + (item.count > 80 ? "..." : ""))
                    .font(.system(size: 13, design: .rounded))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(10)
            .background(isHovered ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(8)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
