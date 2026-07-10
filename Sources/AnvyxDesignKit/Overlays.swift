//
//  Overlays.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// Full-screen dimmed loading overlay, driven by a binding.
///
/// ```swift
/// content.loadingOverlay(isPresented: $isLoading)
/// ```
public struct LoadingOverlay: ViewModifier {
    let isPresented: Bool
    var message: String?
    @Environment(\.anvyxTheme) private var theme

    public func body(content: Content) -> some View {
        content.overlay {
            if isPresented {
                ZStack {
                    Color.black.opacity(0.35).ignoresSafeArea()
                    VStack(spacing: theme.spacing.md) {
                        ProgressView()
                            .controlSize(.large)
                            .tint(.white)
                        if let message {
                            Text(message)
                                .font(.subheadline)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(theme.spacing.xl)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: theme.radius.lg))
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isPresented)
    }
}

public extension View {
    func loadingOverlay(isPresented: Bool, message: String? = nil) -> some View {
        modifier(LoadingOverlay(isPresented: isPresented, message: message))
    }
}

/// A simple card container using the theme surface + radius.
public struct Card<Content: View>: View {
    @ViewBuilder var content: () -> Content
    @Environment(\.anvyxTheme) private var theme

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
            .padding(theme.spacing.md)
            .background(theme.colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous))
    }
}
