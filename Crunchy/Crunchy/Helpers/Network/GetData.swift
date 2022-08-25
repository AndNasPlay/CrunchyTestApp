//
//  GetData.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import Foundation

protocol GetData {
	func getData(completionHandler: @escaping (Pryaniky?, Error?) -> Void)
}
