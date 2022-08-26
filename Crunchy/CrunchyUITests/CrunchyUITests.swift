//
//  CrunchyUITests.swift
//  CrunchyUITests
//
//  Created by Андрей Щекатунов on 26.08.2022.
//

import XCTest

class CrunchyUITests: XCTestCase {

	func testLaunch() throws {
		let app = XCUIApplication()
		app.launch()
	}

	func testTapMainButton() throws {
		let app = XCUIApplication()
		app.launch()
		let button = app.buttons["mainButton"].firstMatch
		XCTAssertTrue(button.isHittable)
		button.tap()
	}

    func testTapDataCells() throws {
		let app = XCUIApplication()
		app.launch()
		let button = app.buttons["mainButton"].firstMatch
		XCTAssertTrue(button.isHittable)
		button.tap()
		let cellText = app.cells["textTableViewCell"].firstMatch
		XCTAssertTrue(cellText.isHittable)
		cellText.tap()
		let textDoneButton = app.buttons["doneButton"].firstMatch
		XCTAssertTrue(textDoneButton.isHittable)
		textDoneButton.tap()
		let cellImage = app.cells["imageTableViewCell"].firstMatch
		XCTAssertTrue(cellImage.isHittable)
		cellImage.tap()
		let imageDoneButton = app.buttons["doneButton"].firstMatch
		XCTAssertTrue(imageDoneButton.isHittable)
		imageDoneButton.tap()
		let cellSelector = app.cells["selectorTableViewCell"].firstMatch
		XCTAssertTrue(cellSelector.isHittable)
		cellSelector.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
