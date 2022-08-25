//
//  NetworkManager.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import Foundation
import Alamofire

struct NetworkManager: GetData {

	static let shared = NetworkManager()
	private let baseURL = "https://pryaniky.com/static/json/sample.json"

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
