//
//  Toast.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// A transient message shown at the top of the screen.
public struct Toast: Equatable, Identifiable, Sendable {
    public enum Style: Sendable { case info, success, warning, error }

    public let id = UUID()
    public var message: String
    public var style: Style

    public init(message: String, style: Style = .info) {
        self.message = message
        self.style = style
    }

    var icon: String {
        switch style {
        case .info:    return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error:   return "xmark.octagon.fill"
        }
    }
}

/// The themed banner used to render a `Toast` (shared by the single-toast and
/// queued-toast presenters).
struct ToastBanner: View {
    let toast: Toast
    @Environment(\.anvyxTheme) private var theme

    private var tint: Color {
        switch toast.style {
        case .info:    return theme.colors.accent
        case .success: return theme.colors.success
        case .warning: return theme.colors.warning
        case .error:   return theme.colors.danger
        }
    }

    var body: some View {
        HStack(spacing: theme.spacing.sm) {
            Image(systemName: toast.icon)
            Text(toast.message).font(.subheadline.weight(.medium))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, theme.spacing.md)
        .padding(.vertical, theme.spacing.sm)
        .background(tint, in: Capsule())
        .padding(.top, theme.spacing.sm)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

/// Presents a `Toast` binding that auto-dismisses after `duration` seconds.
public struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    var duration: TimeInterval

    public func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            if let toast {
                ToastBanner(toast: toast)
                    .onReceive(Timer.publish(every: duration, on: .main, in: .common).autoconnect()) { _ in
                        self.toast = nil
                    }
                    .id(toast.id) // restart the auto-dismiss timer for each new toast
            }
        }
        .animation(.spring(duration: 0.3), value: toast)
    }
}

public extension View {
    func toast(_ toast: Binding<Toast?>, duration: TimeInterval = 2.5) -> some View {
        modifier(ToastModifier(toast: toast, duration: duration))
    }
}
