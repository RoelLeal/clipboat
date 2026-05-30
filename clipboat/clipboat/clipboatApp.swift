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
                                ForEach(clipboardMonitor.copiedItems) { item in
                                    ClipboardItemView(item: item) {
                                        clipboardMonitor.copyToClipboard(item)
                                    } removeAction: {
                                        clipboardMonitor.removeItem(item)
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
                    Button(action: {}) {
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
    let item: ClipItem
    let action: () -> Void
    let removeAction: () -> Void
    @State private var isHovered = false

    var body: some View {
        HStack(spacing: 0) {
            Button(action: action) {
                HStack(spacing: 12) {
                    itemIcon
                    itemContent
                    Spacer()
                }
                .padding(10)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if isHovered {
                Button(action: removeAction) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary.opacity(0.6))
                        .font(.system(size: 14))
                }
                .buttonStyle(.plain)
                .padding(.trailing, 8)
                .transition(.opacity)
            }
        }
        .background(isHovered ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(8)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.15)) {
                isHovered = hovering
            }
        }
    }

    @ViewBuilder
    private var itemIcon: some View {
        switch item {
        case .text:
            Image(systemName: "doc.on.doc")
                .foregroundColor(isHovered ? .blue : .secondary)
                .font(.system(size: 14))
                .frame(width: 16)
        case .link:
            Image(systemName: "link")
                .foregroundColor(isHovered ? .blue : .accentColor)
                .font(.system(size: 14))
                .frame(width: 16)
        case .image:
            Image(systemName: "photo")
                .foregroundColor(isHovered ? .blue : .secondary)
                .font(.system(size: 14))
                .frame(width: 16)
        }
    }

    @ViewBuilder
    private var itemContent: some View {
        switch item {
        case .text(let s):
            Text(s.count > 80 ? String(s.prefix(80)) + "…" : s)
                .font(.system(size: 13, design: .rounded))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)

        case .link(let url):
            VStack(alignment: .leading, spacing: 2) {
                Text(url.host ?? url.absoluteString)
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(.blue)
                    .lineLimit(1)
                if let host = url.host, url.absoluteString != host {
                    Text(url.absoluteString)
                        .font(.system(size: 11, design: .rounded))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }

        case .image(let img, _):
            HStack(spacing: 8) {
                Image(nsImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 38)
                    .cornerRadius(4)
                    .clipped()
                VStack(alignment: .leading, spacing: 2) {
                    Text("Image")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(.primary)
                    Text("\(Int(img.size.width))×\(Int(img.size.height))")
                        .font(.system(size: 11, design: .rounded))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
