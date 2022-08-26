//
//  DataAlertView.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 26.08.2022.
//

import UIKit

protocol DataAlertViewDelegate: AnyObject {
	func done()
}

final class DataAlertView: UIView {

	// MARK: Variables

	weak var delegate: DataAlertViewDelegate?

	private let buttonFontSize: CGFloat = 25.0
	private let doneButtonAnchors: CGFloat = 20.0
	private let doneButtonCornerRadius: CGFloat = 20.0
	private let mainViewCornerRadius: CGFloat = 10.0
	private let lableMinimumScaleFactor: CGFloat = 0.5
	private let nameLableFontSize: CGFloat = 40.0
	private let textLableFontSize: CGFloat = 20.0
	private let mainStackViewLeadingTrailingAnchors: CGFloat = 20.0
	private let mainStackViewTopBottomAnchors: CGFloat = 40.0
	private let mainStackViewSpacing: CGFloat = 20.0

	// MARK: - Subviews

	private(set) lazy var nameLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .mainBlackColor
		text.textAlignment = .center
		text.font = UIFont.boldSystemFont(ofSize: nameLableFontSize)
		text.text = "Name"
		text.adjustsFontSizeToFitWidth = true
		text.minimumScaleFactor = lableMinimumScaleFactor
		text.numberOfLines = 0
		return text
	}()

	private(set) lazy var textLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .mainBlackColor
		text.textAlignment = .center
		text.font = UIFont.systemFont(ofSize: textLableFontSize)
		text.text = "Text"
		text.adjustsFontSizeToFitWidth = true
		text.minimumScaleFactor = lableMinimumScaleFactor
		text.numberOfLines = 0
		return text
	}()

	private(set) lazy var doneButton: UIButton = {
		var button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Done", for: .normal)
		button.setTitleColor(.mainBlackColor, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: buttonFontSize)
		button.layer.cornerRadius = doneButtonCornerRadius
		button.accessibilityIdentifier = "doneButton"
		return button
	}()

	private(set) lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .fillEqually
		stackView.spacing = mainStackViewSpacing
		stackView.backgroundColor = .clear
		return stackView
	}()

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.translatesAutoresizingMaskIntoConstraints = false
		createSubviews()
		constraintsInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.translatesAutoresizingMaskIntoConstraints = false
		createSubviews()
		constraintsInit()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.doneButton.setTitleColor(.white, for: .normal)
		self.doneButton.applyGradient(colors: [UIColor.mainBlueColor.cgColor, UIColor.mainGreenColor.cgColor])
	}

	private func createSubviews() {
		self.backgroundColor = .white
		self.layer.cornerRadius = mainViewCornerRadius
		self.mainStackView.addArrangedSubview(nameLable)
		self.mainStackView.addArrangedSubview(textLable)
		self.mainStackView.addArrangedSubview(doneButton)
		self.addSubview(mainStackView)
		doneButton.addTarget(self,
							   action: #selector(handleDoneTouchUpInseide),
							   for: .touchUpInside)
	}

	// MARK: - Constraints init

	private func constraintsInit() {
		NSLayoutConstraint.activate([
			self.mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
													constant: mainStackViewTopBottomAnchors),
			self.mainStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
													   constant: -mainStackViewTopBottomAnchors),
			self.mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
														constant: mainStackViewLeadingTrailingAnchors),
			self.mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
														 constant: -mainStackViewLeadingTrailingAnchors),
			self.doneButton.leadingAnchor.constraint(equalTo: self.mainStackView.leadingAnchor, constant: doneButtonAnchors),
			self.doneButton.trailingAnchor.constraint(equalTo: self.mainStackView.trailingAnchor, constant: -doneButtonAnchors)
		])
	}

	// MARK: Delegate methods

	@objc func handleDoneTouchUpInseide() {
		self.delegate?.done()
	}
}
