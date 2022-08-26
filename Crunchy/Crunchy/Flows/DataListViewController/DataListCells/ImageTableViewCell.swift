//
//  ImageTableViewCell.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {

	// MARK: Variables

	let identifier: String = "imageTableViewCell"
	private let mainBackgroundViewAnchors: CGFloat = 20.0
	private let mainStackViewAnchors: CGFloat = 20.0
	private let mainImageViewAnchors: CGFloat = 120.0
	private let mainBackgroundViewBorderWidth: CGFloat = 3.0
	private let mainStackViewSpacing: CGFloat = 20.0
	private let mainBackgroundViewCornerRadius: CGFloat = 20.0
	private let nameLableFontSize: CGFloat = 25.0
	private let textLableFontSize: CGFloat = 20.0

	// MARK: - Subviews

	private(set) lazy var nameLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		lable.textAlignment = .center
		lable.textColor = .mainBlackColor
		lable.font = UIFont.boldSystemFont(ofSize: nameLableFontSize)
		return lable
	}()

	private(set) lazy var mainImageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()

	private(set) lazy var textLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		lable.textAlignment = .center
		lable.textColor = .mainBlackColor
		lable.font = UIFont.systemFont(ofSize: textLableFontSize)
		return lable
	}()

	private(set) lazy var mainBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.borderColor = UIColor.mainBlueColor.cgColor
		view.layer.borderWidth = mainBackgroundViewBorderWidth
		view.layer.cornerRadius = mainBackgroundViewCornerRadius
		return view
	}()

	private(set) lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .fill
		stackView.spacing = mainStackViewSpacing
		stackView.backgroundColor = .clear
		return stackView
	}()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: identifier)
		self.selectionStyle = .none
		self.accessibilityIdentifier = "imageTableViewCell"
		setupUI()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func setupUI() {
		self.mainStackView.addArrangedSubview(nameLable)
		self.mainStackView.addArrangedSubview(mainImageView)
		self.mainStackView.addArrangedSubview(textLable)
		self.contentView.addSubview(mainBackgroundView)
		self.mainBackgroundView.addSubview(mainStackView)
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
			self.mainStackView.topAnchor.constraint(equalTo: self.mainBackgroundView.topAnchor,
													constant: mainStackViewAnchors),
			self.mainStackView.leadingAnchor.constraint(equalTo: self.mainBackgroundView.leadingAnchor,
														constant: mainStackViewAnchors),
			self.mainStackView.trailingAnchor.constraint(equalTo: self.mainBackgroundView.trailingAnchor,
														 constant: -mainStackViewAnchors),
			self.mainStackView.bottomAnchor.constraint(equalTo: self.mainBackgroundView.bottomAnchor,
													   constant: -mainStackViewAnchors),
			self.mainImageView.heightAnchor.constraint(equalToConstant: mainImageViewAnchors),
			self.mainImageView.widthAnchor.constraint(equalToConstant: mainImageViewAnchors)
		])
	}

}
