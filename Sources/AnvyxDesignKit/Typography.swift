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

// Typography tokens now live on `ThemeTypography` (see AnvyxTheme.swift), read via
// `@Environment(\.anvyxTheme).typography`. The former global `AppTypography` and
// `Font.app(...)` static API was removed in the re-theme.

/// Registers custom font files bundled with the app/package at runtime, so they
/// don't need to be listed in Info.plist (`UIAppFonts`).
///
/// ```swift
/// FontRegistrar.register(["Inter-Regular", "Inter-Bold"], in: .module)
/// theme.typography.family = FontFamily(regular: "Inter-Regular", medium: "Inter-Medium",
///                                      semibold: "Inter-SemiBold", bold: "Inter-Bold")
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
