//
//  MainScreenCoordinator.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

final class MainScreenCoordinator: Coordinator {

	private(set) var childCoordinators: [Coordinator] = []

	private let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let mainViewController = MainScreenViewController()
		let mainViewModel = MainScreenViewModel()
		mainViewModel.coordinator = self
		mainViewController.viewModel = mainViewModel
		navigationController.setViewControllers([mainViewController], animated: false)
	}

	func mainButtonTouchUpInside() {
		let dataListCoordinator = DataListCoordinator(navigationController: navigationController)
		dataListCoordinator.parentCoordinator = self
		childCoordinators.append(dataListCoordinator)
		dataListCoordinator.start()
	}

	func childDidFinish(_ childCoordinator: Coordinator) { }
}
