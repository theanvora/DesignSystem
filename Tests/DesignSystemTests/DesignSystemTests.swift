//
//  DesignSystemTests.swift
//  DesignSystem
//
//  Created by AnhPT on 02/07/2026.
//

import XCTest
import SwiftUI
@testable import DesignSystem

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
}
