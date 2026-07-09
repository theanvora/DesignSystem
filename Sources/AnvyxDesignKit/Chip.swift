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

    public init(_ title: String, isSelected: Bool = false, action: @escaping () -> Void = {}) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, Theme.spacing.md)
                .padding(.vertical, Theme.spacing.sm)
                .foregroundStyle(isSelected ? Color.white : Theme.colors.textPrimary)
                .background(isSelected ? Theme.colors.accent : Theme.colors.surface, in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

public extension View {
    /// Wrap the view in the standard themed card (surface + padding + radius).
    func cardStyle() -> some View {
        padding(Theme.spacing.md)
            .background(Theme.colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: Theme.radius.md, style: .continuous))
    }
}
