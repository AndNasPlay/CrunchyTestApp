//
//  MainScreenViewModel.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import Foundation

protocol MainScreenViewModelProtocol {
	func getStarted()
}

final class MainScreenViewModel: MainScreenViewModelProtocol {

	var coordinator: MainScreenCoordinator?

	func getStarted() {
		coordinator?.mainButtonTouchUpInside()
	}
}
