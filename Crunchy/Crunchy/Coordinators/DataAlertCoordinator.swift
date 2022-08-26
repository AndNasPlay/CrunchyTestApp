//
//  DataAlertCoordinator.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

final class DataAlertCoordinator: Coordinator {

	var childCoordinators: [Coordinator] = []

	let dataAlertViewController = DataAlertViewController()

	var parentCoordinator: DataListCoordinator?

	func start() { }

	func start(name: String, message: String) {
		let dataAlertViewModel = DataAlertViewModel(name: name, text: message)
		dataAlertViewModel.coordinator = self
		dataAlertViewController.viewModel = dataAlertViewModel
		dataAlertViewController.modalPresentationStyle = .overCurrentContext
		dataAlertViewController.modalTransitionStyle = .crossDissolve
		parentCoordinator?.dataListViewController.present(dataAlertViewController, animated: true, completion: nil)
	}

	func done() {
		dataAlertViewController.dismiss(animated: true) { }
	}

	func childDidFinish(_ childCoordinator: Coordinator) { }
}
