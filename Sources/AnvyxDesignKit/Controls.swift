//
//  Controls.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//

import SwiftUI

/// A themed text field with an optional title label and inline error message.
public struct AnvyxTextField: View {
    private let title: String
    @Binding private var text: String
    private let prompt: String
    private let isSecure: Bool
    private let error: String?
    @Environment(\.anvyxTheme) private var theme

    public init(
        _ title: String,
        text: Binding<String>,
        prompt: String = "",
        isSecure: Bool = false,
        error: String? = nil
    ) {
        self.title = title
        self._text = text
        self.prompt = prompt
        self.isSecure = isSecure
        self.error = error
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xs) {
            if !title.isEmpty {
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(theme.colors.textSecondary)
            }

            field
                .textFieldStyle(.plain)
                .padding(theme.spacing.sm)
                .background(theme.colors.surface, in: RoundedRectangle(cornerRadius: theme.radius.sm, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.radius.sm, style: .continuous)
                        .stroke(error == nil ? Color.clear : theme.colors.danger, lineWidth: 1)
                )

            if let error {
                Text(error)
                    .font(.caption2)
                    .foregroundStyle(theme.colors.danger)
            }
        }
    }

    @ViewBuilder
    private var field: some View {
        if isSecure {
            SecureField(prompt, text: $text)
        } else {
            TextField(prompt, text: $text)
        }
    }
}

/// A themed segmented picker over a list of options.
public struct AnvyxSegmentedControl<Option: Hashable>: View {
    private let options: [Option]
    @Binding private var selection: Option
    private let title: (Option) -> String
    @Namespace private var namespace
    @Environment(\.anvyxTheme) private var theme

    public init(
        _ options: [Option],
        selection: Binding<Option>,
        title: @escaping (Option) -> String
    ) {
        self.options = options
        self._selection = selection
        self.title = title
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                let isSelected = option == selection
                Text(title(option))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(isSelected ? Color.white : theme.colors.textPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, theme.spacing.sm)
                    .background {
                        if isSelected {
                            Capsule()
                                .fill(theme.colors.accent)
                                .matchedGeometryEffect(id: "seg", in: namespace)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation(theme.motion.standard) { selection = option }
                    }
            }
        }
        .padding(theme.spacing.xs)
        .background(theme.colors.surface, in: Capsule())
    }
}

/// A compact themed stepper for an integer value within `range`.
public struct AnvyxStepper: View {
    private let title: String
    @Binding private var value: Int
    private let range: ClosedRange<Int>
    private let step: Int
    @Environment(\.anvyxTheme) private var theme

    public init(_ title: String = "", value: Binding<Int>, in range: ClosedRange<Int>, step: Int = 1) {
        self.title = title
        self._value = value
        self.range = range
        self.step = step
    }

    public var body: some View {
        HStack(spacing: theme.spacing.md) {
            if !title.isEmpty {
                Text(title).font(.subheadline)
                Spacer(minLength: 0)
            }
            button("minus", enabled: value > range.lowerBound) {
                value = max(range.lowerBound, value - step)
            }
            Text("\(value)")
                .font(.body.monospacedDigit().weight(.semibold))
                .frame(minWidth: 28)
            button("plus", enabled: value < range.upperBound) {
                value = min(range.upperBound, value + step)
            }
        }
    }

    private func button(_ symbol: String, enabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.body.weight(.semibold))
                .frame(width: 30, height: 30)
                .background(theme.colors.surface, in: Circle())
                .foregroundStyle(enabled ? theme.colors.accent : theme.colors.textSecondary)
        }
        .buttonStyle(.plain)
        .disabled(!enabled)
    }
}
