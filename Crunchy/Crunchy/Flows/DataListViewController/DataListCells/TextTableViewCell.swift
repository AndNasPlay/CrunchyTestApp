//
//  TextTableViewCell.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

final class TextTableViewCell: UITableViewCell {

	// MARK: Variables

	private let identifier: String = "textTableViewCell"
	private let textStackViewSpacing: CGFloat = 20.0
	private let mainBackgroundViewBorderWidth: CGFloat = 3.0
	private let mainBackgroundViewCornerRadius: CGFloat = 20.0
	private let mainBackgroundViewAnchors: CGFloat = 20.0
	private let textStackViewAnchors: CGFloat = 20.0

	// MARK: - Subviews

	private(set) lazy var nameLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		lable.textAlignment = .center
		return lable
	}()

	private(set) lazy var textLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		lable.textAlignment = .center
		return lable
	}()

	private(set) lazy var mainBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.borderColor = UIColor.mainGreenColor.cgColor
		view.layer.borderWidth = mainBackgroundViewBorderWidth
		self.mainBackgroundView.layer.cornerRadius = mainBackgroundViewCornerRadius
		return view
	}()

	private(set) lazy var textStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .fillProportionally
		stackView.spacing = textStackViewSpacing
		stackView.backgroundColor = .clear
		return stackView
	}()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: identifier)
		self.selectionStyle = .none
		setupUI()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func setupUI() {

		self.textStackView.addArrangedSubview(nameLable)
		self.textStackView.addArrangedSubview(textLable)

		self.contentView.addSubview(mainBackgroundView)
		self.mainBackgroundView.addSubview(textStackView)
		self.backgroundColor = .clear
	}

	func configureCell(item: Datum) {

		self.nameLable.text = item.name
		self.textLable.text = item.data?.text

	}

	// MARK: - Constraints init

	private func setupConstraints() {

		NSLayoutConstraint.activate([

			self.mainBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
														 constant: mainBackgroundViewAnchors),
			self.mainBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
															 constant: mainBackgroundViewAnchors),
			self.mainBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
															  constant: -mainBackgroundViewAnchors),
			self.mainBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
															constant: -mainBackgroundViewAnchors),
			self.textStackView.topAnchor.constraint(equalTo: self.mainBackgroundView.topAnchor,
													constant: textStackViewAnchors),
			self.textStackView.leadingAnchor.constraint(equalTo: self.mainBackgroundView.leadingAnchor,
														constant: textStackViewAnchors),
			self.textStackView.trailingAnchor.constraint(equalTo: self.mainBackgroundView.trailingAnchor,
														 constant: -textStackViewAnchors),
			self.textStackView.bottomAnchor.constraint(equalTo: self.mainBackgroundView.bottomAnchor,
													   constant: -textStackViewAnchors)
		])
	}

}
