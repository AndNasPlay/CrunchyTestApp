//
//  Pryaniky.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import Foundation

// MARK: - Pryaniky
struct Pryaniky: Codable {
	let data: [Datum]?
	let view: [String]?
}

// MARK: - Datum
struct Datum: Codable {
	let name: String?
	let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
	let text: String?
	let url: String?
	let selectedID: Int?
	let variants: [Variants]?

	enum CodingKeys: String, CodingKey {
		case text, url
		case selectedID = "selectedId"
		case variants
	}
}

// MARK: - Variant
struct Variants: Codable {
	let segmentId: Int?
	let text: String?
}

extension Variants {

	private enum CodingKeys: String, CodingKey {
		case segmentId = "id"
		case text
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		segmentId = try container.decode(Int.self, forKey: .segmentId)
		text = try container.decode(String.self, forKey: .text)
	}
}
