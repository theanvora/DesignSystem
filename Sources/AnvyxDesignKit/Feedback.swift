//
//  Feedback.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//

import SwiftUI

// MARK: - Toast queue

/// A serial queue of toasts: enqueue as many as you like and they present one at
/// a time. Inject it, then attach `.toastQueue(_:)` to a root view.
@MainActor
@Observable
public final class ToastQueue {
    public private(set) var current: Toast?
    private var pending: [Toast] = []

    public init() {}

    public func enqueue(_ toast: Toast) {
        pending.append(toast)
        presentNext()
    }

    public func enqueue(_ message: String, style: Toast.Style = .info) {
        enqueue(Toast(message: message, style: style))
    }

    /// Dismiss the visible toast and advance to the next queued one.
    public func dismissCurrent() {
        current = nil
        presentNext()
    }

    public func clear() {
        pending.removeAll()
        current = nil
    }

    private func presentNext() {
        guard current == nil, !pending.isEmpty else { return }
        current = pending.removeFirst()
    }
}

struct ToastQueueModifier: ViewModifier {
    @Bindable var queue: ToastQueue
    var duration: TimeInterval

    func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            if let toast = queue.current {
                ToastBanner(toast: toast)
                    .onReceive(Timer.publish(every: duration, on: .main, in: .common).autoconnect()) { _ in
                        queue.dismissCurrent()
                    }
                    .id(toast.id) // restart the auto-dismiss timer for each queued toast
            }
        }
        .animation(.spring(duration: 0.3), value: queue.current)
    }
}

public extension View {
    /// Present toasts from a `ToastQueue`, one at a time, each auto-dismissing
    /// after `duration` seconds.
    func toastQueue(_ queue: ToastQueue, duration: TimeInterval = 2.5) -> some View {
        modifier(ToastQueueModifier(queue: queue, duration: duration))
    }
}

// MARK: - Skeleton list

/// A shimmering placeholder list shown while real content loads.
public struct SkeletonList: View {
    private let rows: Int
    private let rowHeight: CGFloat
    @Environment(\.anvyxTheme) private var theme

    public init(rows: Int = 6, rowHeight: CGFloat = 56) {
        self.rows = rows
        self.rowHeight = rowHeight
    }

    public var body: some View {
        VStack(spacing: theme.spacing.sm) {
            ForEach(0..<rows, id: \.self) { _ in
                RoundedRectangle(cornerRadius: theme.radius.md, style: .continuous)
                    .fill(theme.colors.surface)
                    .frame(height: rowHeight)
                    .shimmering()
            }
        }
    }
}

// MARK: - Rating

/// A star rating that displays and (optionally) edits a value in `0...count`.
public struct RatingView: View {
    @Binding private var rating: Int
    private let count: Int
    private let isEditable: Bool
    @Environment(\.anvyxTheme) private var theme

    /// Editable rating bound to `rating`.
    public init(rating: Binding<Int>, count: Int = 5) {
        self._rating = rating
        self.count = count
        self.isEditable = true
    }

    /// Read-only rating.
    public init(value: Int, count: Int = 5) {
        self._rating = .constant(value)
        self.count = count
        self.isEditable = false
    }

    public var body: some View {
        HStack(spacing: theme.spacing.xs) {
            ForEach(1...max(1, count), id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundStyle(index <= rating ? theme.colors.warning : theme.colors.textSecondary)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard isEditable else { return }
                        rating = (rating == index) ? index - 1 : index
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating) of \(count)")
    }
}
