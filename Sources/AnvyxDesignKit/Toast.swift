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

    @MainActor
    var tint: Color {
        switch style {
        case .info:    return Theme.colors.accent
        case .success: return Theme.colors.success
        case .warning: return Theme.colors.warning
        case .error:   return Theme.colors.danger
        }
    }
}

/// Presents a `Toast` binding that auto-dismisses after `duration` seconds.
public struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    var duration: TimeInterval

    public func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            if let toast {
                HStack(spacing: Theme.spacing.sm) {
                    Image(systemName: toast.icon)
                    Text(toast.message).font(.subheadline.weight(.medium))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, Theme.spacing.md)
                .padding(.vertical, Theme.spacing.sm)
                .background(toast.tint, in: Capsule())
                .padding(.top, Theme.spacing.sm)
                .transition(.move(edge: .top).combined(with: .opacity))
                .task(id: toast.id) {
                    try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                    self.toast = nil
                }
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
