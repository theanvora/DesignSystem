//
//  LiquidGlass.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//
//  Anvyx wrappers over SwiftUI's iOS 26 Liquid Glass APIs. The whole surface is
//  `@available(iOS 26, *)` so it stays branch-free: a caller supporting older
//  systems gates once at the call site (or uses the non-glass component) instead
//  of every wrapper carrying its own availability fallback.
//

import SwiftUI

@available(iOS 26, *)
public extension View {
    /// Apply a Liquid Glass effect clipped to `shape`. Pass `interactive: true`
    /// for a tappable (reactive) variant.
    func anvyxGlass(interactive: Bool = false, in shape: some Shape = Capsule()) -> some View {
        glassEffect(interactive ? .regular.interactive() : .regular, in: shape)
    }

    /// The `.glass` button style.
    func anvyxGlassButtonStyle() -> some View {
        buttonStyle(.glass)
    }

    /// The `.glassProminent` button style.
    func anvyxProminentGlassButtonStyle() -> some View {
        buttonStyle(.glassProminent)
    }

    /// Extend background content under adjacent bars / safe areas with a soft blur.
    func anvyxBackgroundExtensionEffect() -> some View {
        backgroundExtensionEffect()
    }

    /// Associate this glass shape with `id` inside an ``AnvyxGlassContainer`` so it
    /// can morph/blend with siblings sharing `namespace`.
    func anvyxGlassEffectID(_ id: some Hashable & Sendable, in namespace: Namespace.ID) -> some View {
        glassEffectID(id, in: namespace)
    }
}

/// Groups Liquid Glass shapes so they blend/morph together.
@available(iOS 26, *)
public struct AnvyxGlassContainer<Content: View>: View {
    private let spacing: CGFloat
    @ViewBuilder private let content: () -> Content

    public init(spacing: CGFloat = 20, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        GlassEffectContainer(spacing: spacing, content: content)
    }
}
