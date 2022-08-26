//
//  DataAlertViewController.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 26.08.2022.
//

import UIKit

final class DataAlertViewController: UIViewController, DataAlertViewDelegate {

	private let newView = DataAlertView()

	var viewModel: DataAlertViewModel?

	private(set) lazy var newViewLeadingTrailingAnchor: CGFloat = 40.0
	private(set) lazy var newViewHeightAnchor: CGFloat = 300.0
	private(set) lazy var bgAlphaComponent: CGFloat = 0.6

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .gray.withAlphaComponent(bgAlphaComponent)
		self.view.addSubview(newView)
		newView.delegate = self
		constraintsInit()
		getInfo()
	}

	private func getInfo() {
		self.newView.textLable.text = self.viewModel?.getMessage()
		self.newView.nameLable.text = self.viewModel?.getName()
	}

	private func constraintsInit() {
		NSLayoutConstraint.activate([
			newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
											 constant: newViewLeadingTrailingAnchor),
			newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
											  constant: -newViewLeadingTrailingAnchor),
			newView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			newView.heightAnchor.constraint(equalToConstant: newViewHeightAnchor)
		])
	}

	func done() {
		self.viewModel?.done()
	}
}
