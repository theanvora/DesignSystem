//
//  Theme.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// Central design tokens. Override the palette once at launch to rebrand an app:
///
/// ```swift
/// Theme.colors = .init(accent: .indigo)
/// ```
public enum Theme {
    public static var colors = ColorPalette()
    public static var spacing = Spacing()
    public static var radius = Radius()
}

public struct ColorPalette: Sendable {
    public var accent: Color
    public var background: Color
    public var surface: Color
    public var textPrimary: Color
    public var textSecondary: Color
    public var success: Color
    public var warning: Color
    public var danger: Color

    public init(
        accent: Color = .accentColor,
        background: Color = Color(.systemBackground),
        surface: Color = Color(.secondarySystemBackground),
        textPrimary: Color = .primary,
        textSecondary: Color = .secondary,
        success: Color = .green,
        warning: Color = .orange,
        danger: Color = .red
    ) {
        self.accent = accent
        self.background = background
        self.surface = surface
        self.textPrimary = textPrimary
        self.textSecondary = textSecondary
        self.success = success
        self.warning = warning
        self.danger = danger
    }
}

public struct Spacing: Sendable {
    public var xs: CGFloat = 4
    public var sm: CGFloat = 8
    public var md: CGFloat = 16
    public var lg: CGFloat = 24
    public var xl: CGFloat = 32
    public init() {}
}

public struct Radius: Sendable {
    public var sm: CGFloat = 8
    public var md: CGFloat = 12
    public var lg: CGFloat = 20
    public init() {}
}

public extension Color {
    /// Create a color from a hex string such as `"#FF8800"` or `"FF8800"`.
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var value: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&value)
        let r, g, b, a: Double
        switch cleaned.count {
        case 6:
            r = Double((value & 0xFF0000) >> 16) / 255
            g = Double((value & 0x00FF00) >> 8) / 255
            b = Double(value & 0x0000FF) / 255
            a = 1
        case 8:
            r = Double((value & 0xFF000000) >> 24) / 255
            g = Double((value & 0x00FF0000) >> 16) / 255
            b = Double((value & 0x0000FF00) >> 8) / 255
            a = Double(value & 0x000000FF) / 255
        default:
            r = 0; g = 0; b = 0; a = 1
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
