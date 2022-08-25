//
//  MainScreenViewController.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

final class MainScreenViewController: UIViewController, MainScreenViewDelegate {

	var viewModel: MainScreenViewModel?

	let networkManager = NetworkManager.shared

	// swiftlint:disable force_cast
	private var mainViewControllerView: MainScreenView {
		return self.view as! MainScreenView
	}
	// swiftlint:enable force_cast

	override func viewDidLoad() {
		super.viewDidLoad()
		updateMainView()
	}

	private func updateMainView() {
		self.view = MainScreenView()
		self.mainViewControllerView.delegate = self
	}

	// MARK: Delegate methods

	func getStarted() {
		print("поехали")
		viewModel?.getStarted()
	}
}
