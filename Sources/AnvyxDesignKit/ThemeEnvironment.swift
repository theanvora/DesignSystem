//
//  ThemeEnvironment.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//

import SwiftUI

private struct AnvyxThemeKey: EnvironmentKey {
    // `AnvyxTheme` is `@MainActor`; the environment default is only read on the
    // main actor by SwiftUI, so `assumeIsolated` is safe here.
    static var defaultValue: AnvyxTheme {
        MainActor.assumeIsolated { AnvyxTheme.default }
    }
}

public extension EnvironmentValues {
    /// The current design theme. Defaults to `AnvyxTheme.default`; override with
    /// `.anvyxTheme(_:)`.
    var anvyxTheme: AnvyxTheme {
        get { self[AnvyxThemeKey.self] }
        set { self[AnvyxThemeKey.self] = newValue }
    }
}

public extension View {
    /// Inject a design theme into this view hierarchy. Because `AnvyxTheme` is
    /// `@Observable`, mutating the injected instance re-renders everything that
    /// reads `@Environment(\.anvyxTheme)`.
    func anvyxTheme(_ theme: AnvyxTheme) -> some View {
        environment(\.anvyxTheme, theme)
    }
}
