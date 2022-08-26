//
//  DataListCoordinator.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

final class DataListCoordinator: Coordinator {

	private(set) var childCoordinators: [Coordinator] = []

	private let navigationController: UINavigationController

	let dataListViewController = DataListViewController()

	var parentCoordinator: MainScreenCoordinator?

	var dataAlertViewController: DataAlertViewController?

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let dataListViewModel = DataListViewModel()
		dataListViewModel.coordinator = self
		dataListViewController.viewModel = dataListViewModel
		navigationController.isNavigationBarHidden = true
		navigationController.setViewControllers([dataListViewController], animated: true)
	}

	func getInfo(message: String, name: String) {
		let dataAlertCoordinator = DataAlertCoordinator()
		dataAlertCoordinator.parentCoordinator = self
		dataAlertViewController = DataAlertViewController()
		dataAlertCoordinator.start(name: name, message: message)
	}

	func childDidFinish(_ childCoordinator: Coordinator) {
		if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
			return childCoordinator === coordinator
		}) {
			childCoordinators.remove(at: index)
		}
	}
}
