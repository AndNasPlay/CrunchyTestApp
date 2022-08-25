//
//  MainScreenViewModel.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import Foundation

final class MainScreenViewModel {

	var coordinator: MainScreenCoordinator?

	func getStarted() {
		coordinator?.mainButtonTouchUpInside()
	}
}
