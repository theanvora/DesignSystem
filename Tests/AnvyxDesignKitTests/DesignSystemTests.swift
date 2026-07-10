//
//  DesignSystemTests.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import XCTest
import SwiftUI
import UIKit
@testable import AnvyxDesignKit

final class DesignSystemTests: XCTestCase {
    func testHexColorParsesWithoutCrashing() {
        _ = Color(hex: "#FF8800")
        _ = Color(hex: "00FF0080")
        _ = Color(hex: "bogus")
    }

    func testToastStyleMapping() {
        XCTAssertEqual(Toast(message: "x", style: .success).icon, "checkmark.circle.fill")
        XCTAssertEqual(Toast(message: "x", style: .error).icon, "xmark.octagon.fill")
    }

    // MARK: - Theme foundation (re-theme phase 1)

    func testDynamicColorResolvesDifferentlyForLightAndDark() {
        let token = Color(light: .white, dark: .black)
        let uiColor = UIColor(token)
        let light = uiColor.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        let dark = uiColor.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))

        var lightWhite: CGFloat = 0, darkWhite: CGFloat = 0, alpha: CGFloat = 0
        light.getWhite(&lightWhite, alpha: &alpha)
        dark.getWhite(&darkWhite, alpha: &alpha)
        XCTAssertGreaterThan(lightWhite, darkWhite) // light≈1, dark≈0
    }

    @MainActor
    func testDynamicColorHighContrastFallsBackToNormal() {
        // Fixed (non-adaptive) colors so any difference is due to our resolver,
        // not a system color re-adapting to contrast. With no high-contrast
        // variant supplied, high-contrast dark must resolve to `dark`.
        let fixedDark = Color(.sRGB, red: 0.3, green: 0.3, blue: 0.3, opacity: 1)
        let token = Color(light: .white, dark: fixedDark)
        let uiColor = UIColor(token)
        let highContrastDark = UITraitCollection { mutable in
            mutable.userInterfaceStyle = .dark
            mutable.accessibilityContrast = .high
        }
        let hcDark = uiColor.resolvedColor(with: highContrastDark)
        let plainDark = uiColor.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))
        XCTAssertEqual(hcDark, plainDark)
    }

    @MainActor
    func testThemeTokensAreMutableAtRuntime() {
        let theme = AnvyxTheme()
        theme.colors.accent = .purple
        theme.spacing.md = 20
        theme.typography.family = FontFamily(regular: "R", medium: "M", semibold: "S", bold: "B")
        XCTAssertEqual(theme.spacing.md, 20)
        XCTAssertNotNil(theme.typography.family)
    }

    @MainActor
    func testTypographyProducesFontsForSystemAndCustom() {
        let system = ThemeTypography()
        _ = system.body
        _ = system.largeTitle
        let custom = ThemeTypography(family: FontFamily(regular: "R", medium: "M", semibold: "S", bold: "B"))
        _ = custom.headline // custom family path must not crash
    }

    func testMotionRespectsReduceMotion() {
        let motion = ThemeMotion()
        XCTAssertNil(motion.resolved(motion.standard, reduceMotion: true))
        XCTAssertNotNil(motion.resolved(motion.standard, reduceMotion: false))
    }

    // MARK: - Components (phase 4)

    @MainActor
    func testToastQueuePresentsSequentially() {
        let queue = ToastQueue()
        queue.enqueue("first")
        queue.enqueue("second", style: .success)
        XCTAssertEqual(queue.current?.message, "first")

        queue.dismissCurrent()
        XCTAssertEqual(queue.current?.message, "second")

        queue.dismissCurrent()
        XCTAssertNil(queue.current)
    }

    @MainActor
    func testToastQueueClearRemovesEverything() {
        let queue = ToastQueue()
        queue.enqueue("a")
        queue.enqueue("b")
        queue.clear()
        XCTAssertNil(queue.current)
    }

    func testIconSizeTokens() {
        XCTAssertEqual(AnvyxIcon.Size.small.points, 16)
        XCTAssertEqual(AnvyxIcon.Size.medium.points, 22)
        XCTAssertEqual(AnvyxIcon.Size.large.points, 32)
    }
}
