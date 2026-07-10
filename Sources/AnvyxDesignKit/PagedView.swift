//
//  PagedView.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// A paging container with themed page dots — for onboarding, paywalls, and
/// walkthroughs.
///
/// ```swift
/// PagedView(pages) { page in OnboardPage(page) }
/// ```
public struct PagedView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    private let data: Data
    private let content: (Data.Element) -> Content
    @State private var selection: Data.Element.ID?
    @Environment(\.anvyxTheme) private var theme

    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }

    public var body: some View {
        VStack(spacing: theme.spacing.md) {
            TabView(selection: $selection) {
                ForEach(data) { element in
                    content(element).tag(Optional(element.id))
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            HStack(spacing: theme.spacing.sm) {
                ForEach(data) { element in
                    Circle()
                        .fill(element.id == selection ? theme.colors.accent : theme.colors.textSecondary.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .onAppear { if selection == nil { selection = data.first?.id } }
    }
}
