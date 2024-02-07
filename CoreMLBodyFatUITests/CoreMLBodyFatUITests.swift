//
//  CoreMLBodyFatUITests.swift
//  CoreMLBodyFatUITests
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import XCTest

final class CoreMLBodyFatUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests
        // before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInput() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let _ = app.wait(for: .unknown, timeout: 1)

        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements

        elementsQuery.buttons["Male"].tap()
        elementsQuery.staticTexts["Height, cm"].tap()

        let submitButton = elementsQuery.buttons["Submit"]

        // Height
        app.keys["1"].tap()
        app.keys["8"].tap()
        app.keys["4"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Age
        app.keys["2"].tap()
        app.keys["5"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Weight
        app.keys["7"].tap()
        app.keys["9"].tap()
        app.keys["."].tap()
        app.keys["8"].tap()
        app.keys["3"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Neck
        app.keys["3"].tap()
        app.keys["7"].tap()
        app.keys["."].tap()
        app.keys["8"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Chest
        app.keys["9"].tap()
        app.keys["9"].tap()
        app.keys["."].tap()
        app.keys["6"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Abdomen
        app.keys["8"].tap()
        app.keys["8"].tap()
        app.keys["."].tap()
        app.keys["5"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Biceps
        app.keys["3"].tap()
        app.keys["0"].tap()
        app.keys["."].tap()
        app.keys["5"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Forearm
        app.keys["2"].tap()
        app.keys["9"].tap()
        app.keys["."].tap()
        app.keys["0"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Wrist
        app.keys["1"].tap()
        app.keys["8"].tap()
        app.keys["."].tap()
        app.keys["8"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Hip
        app.keys["9"].tap()
        app.keys["7"].tap()
        app.keys["."].tap()
        app.keys["1"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Thigh
        app.keys["6"].tap()
        app.keys["0"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Knee
        app.keys["3"].tap()
        app.keys["9"].tap()
        app.keys["."].tap()
        app.keys["4"].tap()
        submitButton.tap()
        let _ = app.wait(for: .unknown, timeout: 0.4)

        // Ankle
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["."].tap()
        app.keys["2"].tap()
        submitButton.tap()

        let _ = app.wait(for: .unknown, timeout: 1)

        elementsQuery.buttons["Female"].tap()

        let _ = app.wait(for: .unknown, timeout: 1)
    }
}
