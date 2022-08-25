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
	let id: Int?
	let text: String?
}
