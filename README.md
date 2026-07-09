# DesignSystem

A SwiftUI design system: theme tokens and reusable components to keep apps visually consistent.

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/iOS-17%2B-blue.svg)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

## Features

- **`Theme`** — centralized color palette, spacing, and corner-radius tokens. Rebrand in one line.
- **`AppTypography`** — Dynamic-Type-aware font tokens with a custom-font family and runtime `FontRegistrar`.
- **Button styles** — `.primary` and `.secondary`.
- **Components** — `Card`, `LoadingOverlay`, `Toast`, `AsyncButton`, `EmptyStateView` (built on `ContentUnavailableView`), `Badge`, `Chip`, `PagedView`, `.cardStyle()`, and a `.shimmering()` skeleton modifier.
- **`Color(hex:)`** — hex string initializer (RGB / RGBA).

> Built for iOS 17+ to use the latest SwiftUI APIs.

## Installation

```swift
.package(url: "https://github.com/anvyxhq/DesignSystem.git", branch: "main")
```

## Usage

```swift
import AnvyxDesignKit

// Rebrand once at launch
Theme.colors = ColorPalette(accent: Color(hex: "#5B5BFF"))

// Buttons
Button("Continue") { }.buttonStyle(.primary)

// Loading overlay
content.loadingOverlay(isPresented: isLoading, message: "Processing…")

// Toast
content.toast($toast)   // @State private var toast: Toast?

// Custom fonts
FontRegistrar.register(["Inter-Regular", "Inter-Bold"])
AppTypography.family = FontFamily(regular: "Inter-Regular", medium: "Inter-Medium",
                                  semibold: "Inter-SemiBold", bold: "Inter-Bold")
Text("Title").font(AppTypography.title)
```

## Requirements

- iOS 17+ · Swift 5.9+

## License

MIT
