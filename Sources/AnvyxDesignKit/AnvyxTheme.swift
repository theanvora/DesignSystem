//
//  AnvyxTheme.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//

import SwiftUI
import UIKit

// MARK: - Token groups

/// Dynamic-Type-aware typography tokens. Set `family` to switch the whole app to
/// a custom font; otherwise the system font is used.
public struct ThemeTypography: Sendable {
    public var family: FontFamily?

    public init(family: FontFamily? = nil) {
        self.family = family
    }

    /// A Dynamic-Type-aware font for the given text style + weight.
    public func font(_ style: Font.TextStyle, weight: Font.Weight = .regular, size: CGFloat) -> Font {
        if let family {
            return .custom(family.postScriptName(for: weight), size: size, relativeTo: style)
        }
        return .system(style, design: .default).weight(weight)
    }

    public var largeTitle: Font { font(.largeTitle, weight: .bold, size: 34) }
    public var title: Font      { font(.title, weight: .bold, size: 28) }
    public var headline: Font   { font(.headline, weight: .semibold, size: 17) }
    public var body: Font       { font(.body, weight: .regular, size: 17) }
    public var callout: Font    { font(.callout, weight: .medium, size: 16) }
    public var caption: Font    { font(.caption, weight: .regular, size: 12) }
}

/// Animation tokens for consistent motion across components. Use
/// `resolved(_:reduceMotion:)` to honour the Reduce Motion accessibility setting.
public struct ThemeMotion: Sendable {
    public var quick: Animation
    public var standard: Animation
    public var emphasized: Animation

    public init(
        quick: Animation = .easeOut(duration: 0.15),
        standard: Animation = .easeInOut(duration: 0.25),
        emphasized: Animation = .spring(response: 0.4, dampingFraction: 0.82)
    ) {
        self.quick = quick
        self.standard = standard
        self.emphasized = emphasized
    }

    /// `animation` unless Reduce Motion is on, in which case animation is dropped.
    public func resolved(_ animation: Animation, reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : animation
    }
}

/// Haptic-feedback tokens. Set `isEnabled = false` to silence app-wide haptics.
public struct ThemeHaptics: Sendable {
    public var isEnabled: Bool

    public init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }

    @MainActor
    public func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        guard isEnabled else { return }
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }

    @MainActor
    public func notify(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        guard isEnabled else { return }
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }

    @MainActor
    public func selection() {
        guard isEnabled else { return }
        UISelectionFeedbackGenerator().selectionChanged()
    }
}

// MARK: - Theme

/// The reactive design-token container injected through the SwiftUI environment.
///
/// Read it in a view with `@Environment(\.anvyxTheme) private var theme` and use
/// `theme.colors`, `theme.spacing`, `theme.typography`, … Because it is
/// `@Observable`, mutating any token at runtime (e.g. `theme.colors.accent = …`
/// or swapping to a dark palette) re-renders every view that reads it.
///
/// Colors default to system dynamic colors (already light/dark correct); use
/// `Color(light:dark:…)` for brand colors that need explicit variants.
@Observable
@MainActor
public final class AnvyxTheme {
    public var colors: ColorPalette
    public var spacing: Spacing
    public var radius: Radius
    public var typography: ThemeTypography
    public var motion: ThemeMotion
    public var haptics: ThemeHaptics

    public init(
        colors: ColorPalette = ColorPalette(),
        spacing: Spacing = Spacing(),
        radius: Radius = Radius(),
        typography: ThemeTypography = ThemeTypography(),
        motion: ThemeMotion = ThemeMotion(),
        haptics: ThemeHaptics = ThemeHaptics()
    ) {
        self.colors = colors
        self.spacing = spacing
        self.radius = radius
        self.typography = typography
        self.motion = motion
        self.haptics = haptics
    }

    /// The shared default theme used when none is injected into the environment.
    public static let `default` = AnvyxTheme()
}
