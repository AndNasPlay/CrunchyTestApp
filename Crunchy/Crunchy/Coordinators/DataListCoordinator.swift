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

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let dataListViewModel = DataListViewModel()
		dataListViewModel.coordinator = self
		dataListViewController.viewModel = dataListViewModel
		navigationController.setViewControllers([dataListViewController], animated: false)
	}

	func getInfo(message: String) {
		let alertController = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(action)
		dataListViewController.present(alertController, animated: true, completion: nil)
	}

	func childDidFinish(_ childCoordinator: Coordinator) {
		if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
			return childCoordinator === coordinator
		}) {
			childCoordinators.remove(at: index)
		}
	}
}
