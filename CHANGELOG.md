# Changelog

All notable changes to the **clipboat** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0] - 2026-05-30

### Added
- `.gitignore` with comprehensive Xcode, Swift, macOS, CocoaPods, Carthage, and environment exclusions
- Untracked previously committed `UserInterfaceState.xcuserstate` from git index

---

## [0.0.1] - 2026-05-18

### Added
- **Initial Release of Clipboat**: A lightweight, native macOS menu bar clipboard manager built entirely with SwiftUI.
- **Dynamic Clipboard Monitoring**: Periodically scans the system pasteboard and captures copied text items in real-time.
- **Sleek Menu Bar Interface**: Runs quietly in the macOS menu bar with a premium `doc.on.clipboard` icon, matching modern macOS design aesthetics.
- **Interactive History List**: Scrollable popover displaying recently copied items. Hovering shows micro-animations (background highlighting and icon color transitions).
- **Fast Re-copying**: Click on any past clip inside the history popover to instantly copy it back to the clipboard.
- **Trash/Clear History Button**: A quick-action button in the header to clear all saved clipboard history instantly.
- **Quit Keyboard Shortcut**: Option to close the application immediately using `Cmd+Q` or clicking the native Quit button.
- **Deployment Pipeline**: Integrated a fully automated GitHub Actions pipeline for compiling, zipping, tagging, and distributing new releases.
