//
//  Icon.swift
//  DesignSystem
//
//  Created by AnhPT on 10/07/2026.
//

import SwiftUI

/// A themed SF Symbol with standardized size tokens, defaulting to the theme's
/// primary text color.
public struct AnvyxIcon: View {
    public enum Size: Sendable {
        case small, medium, large

        var points: CGFloat {
            switch self {
            case .small:  return 16
            case .medium: return 22
            case .large:  return 32
            }
        }
    }

    private let systemName: String
    private let size: Size
    private let color: Color?
    @Environment(\.anvyxTheme) private var theme

    public init(_ systemName: String, size: Size = .medium, color: Color? = nil) {
        self.systemName = systemName
        self.size = size
        self.color = color
    }

    public var body: some View {
        Image(systemName: systemName)
            .font(.system(size: size.points))
            .foregroundStyle(color ?? theme.colors.textPrimary)
    }
}
