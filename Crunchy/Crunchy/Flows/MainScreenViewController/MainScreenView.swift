//
//  MainScreenView.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

protocol MainScreenViewDelegate: AnyObject {
	func getStarted()
}

final class MainScreenView: UIView {

	// MARK: Variables

	private let mainButtonHeightAnchor: CGFloat = 80.0
	private let mainButtonTopAnchor: CGFloat = 10.0
	private let mainButtonTrailingLeadingAnchor: CGFloat = 60.0
	private let mainButtonFont: CGFloat = 30.0
	private let logoImageViewHeightAnchor: CGFloat = 100.0
	private let logoImageViewTopAnchor: CGFloat = 150.0
	private let logoImageViewTrailingLeadingAnchor: CGFloat = 60.0

	weak var delegate: MainScreenViewDelegate?

	// MARK: - Subviews

	private(set) lazy var logoImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.image = UIImage(named: "logo")
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private(set) lazy var mainButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Start", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: mainButtonFont)
		button.titleLabel?.adjustsFontSizeToFitWidth = true
		button.accessibilityIdentifier = "mainButton"
		return button
	}()

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupUI()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupUI()
	}

	private func setupUI() {
		self.backgroundColor = .white
		self.addSubview(logoImageView)
		self.addSubview(mainButton)
		setupConstraints()
		self.mainButton.addTarget(self,
								  action: #selector(handleGetData),
								  for: .touchUpInside)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.mainButton.applyGradient(colors: [UIColor.mainBlueColor.cgColor, UIColor.mainGreenColor.cgColor])
	}

	// MARK: - Constraints init

	private func setupConstraints() {
		let safeArea = self.safeAreaLayoutGuide

		NSLayoutConstraint.activate([

			self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor,
													constant: logoImageViewTopAnchor),
			self.logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
														constant: logoImageViewTrailingLeadingAnchor),
			self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
														 constant: -logoImageViewTrailingLeadingAnchor),
			self.logoImageView.heightAnchor.constraint(equalToConstant: logoImageViewHeightAnchor),

			self.mainButton.topAnchor.constraint(equalTo: safeArea.centerYAnchor,
												 constant: mainButtonTopAnchor),
			self.mainButton.heightAnchor.constraint(equalToConstant: mainButtonHeightAnchor),
			self.mainButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
													 constant: mainButtonTrailingLeadingAnchor),
			self.mainButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
													 constant: mainButtonTrailingLeadingAnchor),
			self.mainButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
													  constant: -mainButtonTrailingLeadingAnchor)
		])
	}

	// MARK: Delegate methods

	@objc func handleGetData() {
		delegate?.getStarted()
	}
}
