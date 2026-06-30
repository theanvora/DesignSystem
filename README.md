# DesignSystem

A SwiftUI design system: theme tokens and reusable components to keep apps visually consistent.

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/iOS-16%2B-blue.svg)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

## Features

- **`Theme`** — centralized color palette, spacing, and corner-radius tokens. Rebrand in one line.
- **Button styles** — `.primary` and `.secondary`.
- **Components** — `Card`, `LoadingOverlay`, and `Toast`.
- **`Color(hex:)`** — hex string initializer (RGB / RGBA).

## Installation

```swift
.package(url: "https://github.com/anvyxhq/DesignSystem.git", from: "1.0.0")
```

## Usage

```swift
import DesignSystem

// Rebrand once at launch
Theme.colors = ColorPalette(accent: Color(hex: "#5B5BFF"))

// Buttons
Button("Continue") { }.buttonStyle(.primary)

// Loading overlay
content.loadingOverlay(isPresented: isLoading, message: "Processing…")

// Toast
content.toast($toast)   // @State private var toast: Toast?
```

## Requirements

- iOS 16.0+ · Swift 5.9+

## License

MIT
