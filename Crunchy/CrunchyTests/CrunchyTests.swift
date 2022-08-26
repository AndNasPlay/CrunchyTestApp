//
//  CrunchyTests.swift
//  CrunchyTests
//
//  Created by Андрей Щекатунов on 26.08.2022.
//

import XCTest
@testable import Crunchy

class CrunchyTests: XCTestCase {

	func testGetData() throws {
		let getData = try XCTUnwrap(NetworkManager.shared)
		getData.getData { data, error in
			switch data {
			case .some(let model):
				XCTAssertEqual(model.view?.count ?? 0 > 0, true)
				XCTAssertEqual(model.data?.count ?? 0 > 0, true)
			case .none:
				XCTAssertEqual(error != nil, true)
			}
		}
	}
}
