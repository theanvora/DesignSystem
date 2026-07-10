//
//  Shimmer.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// A moving gradient "skeleton" shimmer for loading placeholders.
///
/// ```swift
/// RoundedRectangle(cornerRadius: 8)
///     .fill(theme.colors.surface)
///     .frame(height: 16)
///     .shimmering()
/// ```
public struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = -1
    var active: Bool

    public func body(content: Content) -> some View {
        guard active else { return AnyView(content) }
        return AnyView(
            content
                .overlay(gradient.mask(content))
                .onAppear {
                    withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                        phase = 2
                    }
                }
        )
    }

    private var gradient: some View {
        LinearGradient(
            colors: [.clear, .white.opacity(0.6), .clear],
            startPoint: .leading,
            endPoint: .trailing
        )
        .rotationEffect(.degrees(20))
        .offset(x: phase * 200)
    }
}

public extension View {
    func shimmering(active: Bool = true) -> some View {
        modifier(Shimmer(active: active))
    }

    /// Replaces the view with a shimmering placeholder block while `isLoading`.
    @ViewBuilder
    func redactedShimmer(_ isLoading: Bool) -> some View {
        redacted(reason: isLoading ? .placeholder : [])
            .shimmering(active: isLoading)
    }
}
