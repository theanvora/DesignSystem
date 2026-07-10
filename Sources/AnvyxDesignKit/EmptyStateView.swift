//
//  EmptyStateView.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// A reusable empty / error placeholder with an optional call-to-action.
public struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String?
    let actionTitle: String?
    let action: (() -> Void)?

    public init(
        icon: String,
        title: String,
        message: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: icon)
        } description: {
            if let message { Text(message) }
        } actions: {
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

public extension EmptyStateView {
    /// "No results" placeholder for empty searches/filters.
    static func noResults(
        title: String = "No results",
        message: String? = "Try a different search or filter.",
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> EmptyStateView {
        EmptyStateView(icon: "magnifyingglass", title: title, message: message, actionTitle: actionTitle, action: action)
    }

    /// Generic error placeholder with an optional retry action.
    static func error(
        title: String = "Something went wrong",
        message: String? = nil,
        retryTitle: String? = "Try Again",
        retry: (() -> Void)? = nil
    ) -> EmptyStateView {
        EmptyStateView(icon: "exclamationmark.triangle", title: title, message: message, actionTitle: retryTitle, action: retry)
    }

    /// Offline placeholder.
    static func offline(
        title: String = "You're offline",
        message: String? = "Check your connection and try again.",
        retryTitle: String? = "Retry",
        retry: (() -> Void)? = nil
    ) -> EmptyStateView {
        EmptyStateView(icon: "wifi.slash", title: title, message: message, actionTitle: retryTitle, action: retry)
    }

    /// Empty-collection placeholder (nothing created yet).
    static func empty(
        icon: String = "tray",
        title: String,
        message: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> EmptyStateView {
        EmptyStateView(icon: icon, title: title, message: message, actionTitle: actionTitle, action: action)
    }
}

/// A small pill badge (counts, statuses).
public struct Badge: View {
    let text: String
    var color: Color?
    @Environment(\.anvyxTheme) private var theme

    /// `color` defaults to the theme accent when `nil`.
    public init(_ text: String, color: Color? = nil) {
        self.text = text
        self.color = color
    }

    public var body: some View {
        Text(text)
            .font(.caption2.weight(.bold))
            .foregroundStyle(.white)
            .padding(.horizontal, theme.spacing.sm)
            .padding(.vertical, 2)
            .background(color ?? theme.colors.accent, in: Capsule())
    }
}
