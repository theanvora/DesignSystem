//
//  LiquidGlassTests.swift
//  DesignSystem
//
//  Created by AnhPT on 14/07/2026.
//

import XCTest
import SwiftUI
@testable import AnvyxDesignKit

// Compile-level coverage of the iOS 26 Liquid Glass wrappers (runs only on iOS 26+).
@available(iOS 26, *)
final class LiquidGlassTests: XCTestCase {
    func testGlassWrappersCompose() {
        _ = Text("x").anvyxGlass()
        _ = Text("x").anvyxGlass(interactive: true, in: RoundedRectangle(cornerRadius: 8))
        _ = Button("x") {}.anvyxGlassButtonStyle()
        _ = Button("x") {}.anvyxProminentGlassButtonStyle()
        _ = Color.clear.anvyxBackgroundExtensionEffect()
        _ = AnvyxGlassContainer { Text("a"); Text("b") }
        XCTAssertTrue(true)
    }
}
