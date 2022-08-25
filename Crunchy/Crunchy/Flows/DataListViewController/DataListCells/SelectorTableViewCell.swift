//
//  SelectorTableViewCell.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

protocol SelectorTableViewCellDelegate: AnyObject {
	func changeValue()
}

final class SelectorTableViewCell: UITableViewCell {

	// MARK: Variables

	private let identifier: String = "selectorTableViewCell"
	private let mainBackgroundViewAnchors: CGFloat = 20.0
	private let mainStackViewAnchors: CGFloat = 20.0
	private let mainBackgroundViewBorderWidth: CGFloat = 3.0
	private let mainStackViewSpacing: CGFloat = 20.0
	private let mainBackgroundViewCornerRadius: CGFloat = 20.0
	weak var delegate: SelectorTableViewCellDelegate?

	// MARK: - Subviews

	private(set) lazy var nameLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		lable.textAlignment = .center
		return lable
	}()

	private(set) lazy var segmentControl: UISegmentedControl = {
		let segmentControl = UISegmentedControl(items: ["1", "2", "3"])
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		segmentControl.selectedSegmentTintColor = .mainRedColor
		segmentControl.tintColor = .lightGray
		return segmentControl
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
		view.layer.borderColor = UIColor.mainRedColor.cgColor
		view.layer.borderWidth = mainBackgroundViewBorderWidth
		view.layer.cornerRadius = mainBackgroundViewCornerRadius
		return view
	}()

	private(set) lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .fillProportionally
		stackView.spacing = mainStackViewSpacing
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

		self.mainStackView.addArrangedSubview(nameLable)
		self.mainStackView.addArrangedSubview(segmentControl)
		self.mainStackView.addArrangedSubview(textLable)

		self.contentView.addSubview(mainBackgroundView)
		self.mainBackgroundView.addSubview(mainStackView)
		self.backgroundColor = .clear
	}

	private func addAction() {
		self.segmentControl.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
	}

	func configureCell(item: Datum) {

		self.nameLable.text = item.name
		self.textLable.text = item.data?.variants?[(item.data?.selectedID ?? 1)].text ?? "1"
		self.segmentControl.selectedSegmentIndex = (item.data?.selectedID) ?? 1
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
													   constant: -mainStackViewAnchors)
		])
	}

	@objc func handleValueChange() {
		delegate?.changeValue()
	}

}
