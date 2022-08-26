//
//  DataAlertViewModel.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 26.08.2022.
//

import Foundation

protocol DataAlertViewModelProtocol {
	func getName() -> String
	func getMessage() -> String
	func done()
}

final class DataAlertViewModel: DataAlertViewModelProtocol {

	var coordinator: DataAlertCoordinator?

	private var name: String
	private var text: String

	init(name: String, text: String) {
		self.name = name
		self.text = text
	}

	func getName() -> String {
		self.name
	}

	func getMessage() -> String {
		self.text
	}

	func done() {
		self.coordinator?.done()
	}

}
