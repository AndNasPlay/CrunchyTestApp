//
//  NetworkManager.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import Foundation
import Alamofire

enum TestCase: String {
	case moreVariants = "https://chat.pryaniky.com/json/data-default-order-more-variants.json"
	case moreItems = "https://chat.pryaniky.com/json/data-custom-order-much-more-items-in-data.json"
	case customSelectedId = "https://chat.pryaniky.com/json/data-custom-selected-id.json"
	case customDataInView = "https://chat.pryaniky.com/json/data-default-order-custom-data-in-view.json"
}

struct NetworkManager: GetData {

	static let shared = NetworkManager()
	private let baseURL = TestCase.customDataInView.rawValue

	private init() {}

	func getData(completionHandler: @escaping (Pryaniky?, Error?) -> Void) {
		let request = AF.request(baseURL)
		request.responseDecodable(of: Pryaniky.self) { (response) in
			switch response.result {
			case .success(let result):
				guard result.data != nil else { return }
				completionHandler(result, nil)
			case .failure(let error):
				completionHandler(nil, error)
			}

		}
	}
}
