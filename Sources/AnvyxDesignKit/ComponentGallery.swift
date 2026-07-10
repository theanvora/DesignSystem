//
//  ComponentGallery.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//

import SwiftUI

/// A single scrollable showcase of the design system's components. Used by the
/// SwiftUI previews below and by the rendering (snapshot) tests to exercise every
/// component in light/dark and at large Dynamic Type sizes.
struct ComponentGallery: View {
    @State private var chipSelected = true
    @State private var segment = 0
    @State private var steps = 2
    @State private var rating = 3
    @State private var text = ""
    @Environment(\.anvyxTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.lg) {
                Group {
                    Button("Primary") {}.buttonStyle(.primary)
                    Button("Secondary") {}.buttonStyle(.secondary)
                    Button("Glass") {}.anvyxGlassButtonStyle()
                }

                HStack(spacing: theme.spacing.sm) {
                    Chip("Selected", isSelected: chipSelected) { chipSelected.toggle() }
                    Chip("Off")
                    Badge("9")
                }

                AnvyxSegmentedControl([0, 1, 2], selection: $segment) { "Tab \($0 + 1)" }
                AnvyxTextField("Email", text: $text, prompt: "you@anvyx.dev")
                AnvyxStepper("Quantity", value: $steps, in: 0...9)
                RatingView(rating: $rating)

                HStack(spacing: theme.spacing.md) {
                    AnvyxIcon("bolt.fill", size: .large, color: theme.colors.warning)
                    AnvyxIcon("heart.fill", color: theme.colors.danger)
                }

                Card {
                    Text("Card content").font(theme.typography.headline)
                }

                SkeletonList(rows: 2)
                EmptyStateView.noResults()
            }
            .padding(theme.spacing.md)
        }
        .background(theme.colors.background)
    }
}

#Preview("Gallery – Light") {
    ComponentGallery()
        .anvyxTheme(AnvyxTheme())
        .preferredColorScheme(.light)
}

#Preview("Gallery – Dark") {
    ComponentGallery()
        .anvyxTheme(AnvyxTheme())
        .preferredColorScheme(.dark)
}

#Preview("Gallery – XXL type") {
    ComponentGallery()
        .anvyxTheme(AnvyxTheme())
        .environment(\.dynamicTypeSize, .accessibility3)
}
