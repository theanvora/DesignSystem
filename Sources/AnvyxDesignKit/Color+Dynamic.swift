//
//  Color+Dynamic.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//

import SwiftUI
import UIKit

public extension Color {
    /// A color that resolves at render time from the current interface style and
    /// accessibility contrast — so a single token adapts to light/dark and
    /// increased-contrast without the call site branching.
    ///
    /// High-contrast variants fall back to their normal-contrast counterpart when
    /// not supplied.
    init(
        light: Color,
        dark: Color,
        highContrastLight: Color? = nil,
        highContrastDark: Color? = nil
    ) {
        self.init(uiColor: UIColor { traits in
            let isDark = traits.userInterfaceStyle == .dark
            let isHighContrast = traits.accessibilityContrast == .high
            let resolved: Color
            switch (isDark, isHighContrast) {
            case (true, true):   resolved = highContrastDark ?? dark
            case (true, false):  resolved = dark
            case (false, true):  resolved = highContrastLight ?? light
            case (false, false): resolved = light
            }
            return UIColor(resolved)
        })
    }
}
