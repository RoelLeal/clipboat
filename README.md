# ⛵ clipboat

[![Swift](https://img.shields.io/badge/Swift-5.0+-FA7343?style=flat-square&logo=swift&logoColor=white)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-macOS%2014.0+-000000?style=flat-square&logo=apple&logoColor=white)](https://apple.com)
[![Release](https://img.shields.io/badge/Release-v0.0.1-blue?style=flat-square)](https://github.com/RoelLeal/clipboat/releases)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

**clipboat** is a lightweight, ultra-fast, and open-source clipboard history manager designed exclusively for macOS. Built natively using SwiftUI, it lives quietly in your menu bar and helps you keep track of everything you copy, enabling you to boost your productivity.

---

## ✨ Features

- **🚀 Native & Lightweight**: Built 100% with Swift and SwiftUI. It uses minimal system resources and starts instantly.
- **🔄 Dynamic Clipboard Monitor**: Automatically tracks system clipboard changes in real-time.
- **🎨 Glassmorphic Modern UI**: A sleek, popover window that blends seamlessly into the macOS interface, with beautiful hover micro-animations.
- **⚡ Quick Re-copy**: Click any item in your history list to copy it back to your active clipboard immediately.
- **🧹 Instant Clear**: A single click on the trash icon clears your history securely.
- **⌨️ Menu Bar Popover**: Accessible anytime from the menu bar with the standard clipboard icon.
- **🔒 Private & Secure**: Works entirely offline. Your clipboard data never leaves your local machine.

---

## 📦 Installation

To download and run the latest pre-compiled version of **clipboat**:

### Option A: Disk Image (.dmg) — Recommended
1. Go to the [Releases](https://github.com/RoelLeal/clipboat/releases) page.
2. Download the `clipboat.dmg` installer for the latest version.
3. Double-click the `clipboat.dmg` file to mount it.
4. Drag the **clipboat** icon into the **Applications** folder shortcut in the disk image window.

### Option B: ZIP Archive (.zip)
1. Go to the [Releases](https://github.com/RoelLeal/clipboat/releases) page.
2. Download the `clipboat.zip` file.
3. Double-click the `clipboat.zip` file to extract `clipboat.app`.
4. Drag `clipboat.app` to your `/Applications` folder.

---

5. Launch **clipboat** from your Applications folder or via Spotlight!

> [!NOTE]
> As clipboat is open source and distributed directly without Apple Developer Program signing, you might need to right-click the app and choose **Open** the first time you run it, or allow it under **System Settings > Privacy & Security**.

---

## 🛠️ Build Locally

If you'd like to build **clipboat** from source:

### Prerequisites
- macOS 14.0 or newer
- Xcode 15.0 or newer

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/RoelLeal/clipboat.git
   cd clipboat
   ```
2. Open the project in Xcode:
   ```bash
   open clipboat/clipboat.xcodeproj
   ```
3. Press `Cmd + R` inside Xcode to compile and run the application!

---

## ⚙️ CI/CD Pipeline & Releases

**clipboat** uses an automated GitHub Actions workflow to release and package new versions. 

Whenever a release tag (e.g. `v0.0.1`) is pushed, or when the release workflow is manually triggered via the Actions tab:
1. The project is checked out.
2. The Swift codebase is compiled and archived using `xcodebuild` (ad-hoc signed for open-source distribution).
3. The `.app` bundle is packaged into both a high-compression `.zip` archive (preserving file execution permissions) and a native `.dmg` Disk Image.
4. A formal GitHub Release is generated automatically, appending both compiled binaries as downloadable assets.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
