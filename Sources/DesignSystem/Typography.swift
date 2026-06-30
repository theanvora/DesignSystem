//
//  Typography.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI
import CoreText

/// Names of a custom font's weights. Leave `AppTypography.family` as `nil` to use
/// the system font.
public struct FontFamily: Sendable {
    public var regular: String
    public var medium: String
    public var semibold: String
    public var bold: String

    public init(regular: String, medium: String, semibold: String, bold: String) {
        self.regular = regular
        self.medium = medium
        self.semibold = semibold
        self.bold = bold
    }

    func postScriptName(for weight: Font.Weight) -> String {
        switch weight {
        case .bold, .heavy, .black:        return bold
        case .semibold:                    return semibold
        case .medium:                      return medium
        default:                            return regular
        }
    }
}

/// Typography tokens that scale with Dynamic Type. Set `family` once at launch to
/// switch the whole app to a custom font; otherwise the system font is used.
public enum AppTypography {
    public static var family: FontFamily?

    /// A Dynamic-Type-aware font for the given text style + weight.
    public static func font(_ style: Font.TextStyle, weight: Font.Weight = .regular, size: CGFloat) -> Font {
        if let family {
            return .custom(family.postScriptName(for: weight), size: size, relativeTo: style)
        }
        return .system(style, design: .default).weight(weight)
    }

    // Common tokens
    public static var largeTitle: Font { font(.largeTitle, weight: .bold, size: 34) }
    public static var title: Font      { font(.title, weight: .bold, size: 28) }
    public static var headline: Font   { font(.headline, weight: .semibold, size: 17) }
    public static var body: Font       { font(.body, weight: .regular, size: 17) }
    public static var callout: Font    { font(.callout, weight: .medium, size: 16) }
    public static var caption: Font    { font(.caption, weight: .regular, size: 12) }
}

/// Registers custom font files bundled with the app/package at runtime, so they
/// don't need to be listed in Info.plist (`UIAppFonts`).
///
/// ```swift
/// FontRegistrar.register(["Inter-Regular", "Inter-Bold"], in: .module)
/// AppTypography.family = FontFamily(regular: "Inter-Regular", medium: "Inter-Medium",
///                                   semibold: "Inter-SemiBold", bold: "Inter-Bold")
/// ```
public enum FontRegistrar {
    @discardableResult
    public static func register(_ names: [String], extension ext: String = "ttf", in bundle: Bundle = .main) -> Bool {
        var allOK = true
        for name in names {
            guard let url = bundle.url(forResource: name, withExtension: ext) else { allOK = false; continue }
            if !CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil) {
                allOK = false
            }
        }
        return allOK
    }
}

public extension Font {
    /// Shorthand for `AppTypography.font(...)`.
    static func app(_ style: Font.TextStyle, weight: Font.Weight = .regular, size: CGFloat) -> Font {
        AppTypography.font(style, weight: weight, size: size)
    }
}
