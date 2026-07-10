//
//  Buttons.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// Filled, full-width primary button style aligned with the current theme.
public struct PrimaryButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        Rendered(configuration: configuration)
    }

    // A ButtonStyle can't read `@Environment` directly; its body view can.
    private struct Rendered: View {
        let configuration: Configuration
        @Environment(\.anvyxTheme) private var theme

        var body: some View {
            configuration.label
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, theme.spacing.md)
                .background(theme.colors.accent)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous))
                .opacity(configuration.isPressed ? 0.85 : 1)
                .scaleEffect(configuration.isPressed ? 0.98 : 1)
                .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
        }
    }
}

/// Bordered secondary button style.
public struct SecondaryButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        Rendered(configuration: configuration)
    }

    private struct Rendered: View {
        let configuration: Configuration
        @Environment(\.anvyxTheme) private var theme

        var body: some View {
            configuration.label
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, theme.spacing.md)
                .foregroundStyle(theme.colors.accent)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous)
                        .stroke(theme.colors.accent, lineWidth: 1.5)
                )
                .opacity(configuration.isPressed ? 0.6 : 1)
        }
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { .init() }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle { .init() }
}
