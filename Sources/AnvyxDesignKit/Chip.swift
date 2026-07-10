//
//  Chip.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// A selectable pill (filters, tags, choices).
public struct Chip: View {
    private let title: String
    private let isSelected: Bool
    private let action: () -> Void
    @Environment(\.anvyxTheme) private var theme

    public init(_ title: String, isSelected: Bool = false, action: @escaping () -> Void = {}) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, theme.spacing.md)
                .padding(.vertical, theme.spacing.sm)
                .foregroundStyle(isSelected ? Color.white : theme.colors.textPrimary)
                .background(isSelected ? theme.colors.accent : theme.colors.surface, in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

/// Wraps a view in the standard themed card (surface + padding + radius).
private struct CardStyleModifier: ViewModifier {
    @Environment(\.anvyxTheme) private var theme

    func body(content: Content) -> some View {
        content
            .padding(theme.spacing.md)
            .background(theme.colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous))
    }
}

public extension View {
    /// Wrap the view in the standard themed card (surface + padding + radius).
    func cardStyle() -> some View {
        modifier(CardStyleModifier())
    }
}
