//
//  AsyncButton.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import SwiftUI

/// A button that runs an async action and shows a progress spinner while it's in
/// flight, disabling itself to prevent double taps.
///
/// ```swift
/// AsyncButton {
///     try? await purchases.purchase(product)
/// } label: {
///     Text("Subscribe")
/// }
/// .buttonStyle(.primary)
/// ```
public struct AsyncButton<Label: View>: View {
    private let role: ButtonRole?
    private let action: () async -> Void
    private let label: () -> Label

    @State private var isRunning = false

    public init(
        role: ButtonRole? = nil,
        action: @escaping () async -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.role = role
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(role: role) {
            isRunning = true
            Task {
                await action()
                isRunning = false
            }
        } label: {
            label()
                .opacity(isRunning ? 0 : 1)
                .overlay {
                    if isRunning {
                        ProgressView().controlSize(.small)
                    }
                }
        }
        .disabled(isRunning)
        .allowsHitTesting(!isRunning)
    }
}
