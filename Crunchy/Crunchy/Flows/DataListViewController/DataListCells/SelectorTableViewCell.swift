//
//  SelectorTableViewCell.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

protocol SelectorTableViewCellDelegate: AnyObject {
	func changeValue(segment: Int)
}

final class SelectorTableViewCell: UITableViewCell {

	// MARK: Variables

	let identifier: String = "selectorTableViewCell"
	private let mainBackgroundViewAnchors: CGFloat = 20.0
	private let mainStackViewAnchors: CGFloat = 20.0
	private let mainBackgroundViewBorderWidth: CGFloat = 3.0
	private let mainStackViewSpacing: CGFloat = 20.0
	private let mainBackgroundViewCornerRadius: CGFloat = 20.0
	private let segmentControlWidthAnchorMultiplier: CGFloat = 0.7
	private let nameLableFontSize: CGFloat = 25.0
	private let textLableFontSize: CGFloat = 20.0
	private var datum: Datum?
	weak var delegate: SelectorTableViewCellDelegate?

	// MARK: - Subviews

	private(set) lazy var nameLable: UILabel = {
		let lable = UILabel()
		lable.numberOfLines = 0
		lable.textAlignment = .center
		lable.font = UIFont.boldSystemFont(ofSize: nameLableFontSize)
		lable.textColor = .mainBlackColor
		return lable
	}()

	private(set) lazy var segmentControl: UISegmentedControl = {
		let segmentControl = UISegmentedControl()
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		segmentControl.selectedSegmentTintColor = .mainRedColor
		segmentControl.tintColor = .lightGray
		segmentControl.setTitleTextAttributes([
			NSAttributedString.Key.foregroundColor: UIColor.mainBlackColor],
											  for: .normal)
		return segmentControl
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
		stackView.distribution = .fill
		stackView.spacing = mainStackViewSpacing
		stackView.backgroundColor = .clear
		return stackView
	}()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: identifier)
		self.selectionStyle = .none
		self.accessibilityIdentifier = "selectorTableViewCell"
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
		addAction()
	}

	private func addAction() {
		self.segmentControl.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
	}

	private func updateSegmentControl(variants: [Variants]) {
		if self.segmentControl.numberOfSegments == 0 {
			for counter in 0..<variants.count {
				guard let variantId = variants[counter].segmentId else { return }
				self.segmentControl.insertSegment(withTitle: "\(variantId)", at: counter, animated: false)
			}
		} else {
			self.segmentControl.removeAllSegments()
			for counter in 0..<variants.count {
				guard let variantId = variants[counter].segmentId else { return }
				self.segmentControl.insertSegment(withTitle: "\(variantId)", at: counter, animated: false)
			}
		}
	}

	func configureCell(item: Datum) {
		self.datum = item
		self.nameLable.text = item.name
		if let variants = item.data?.variants {
			updateSegmentControl(variants: variants)
		}
		if let selectedId = item.data?.selectedID {
			guard let variantsCount = item.data?.variants?.count else { return }
			guard let variants = item.data?.variants else { return }
			for counter in 0..<variantsCount {
				if variants[counter].segmentId == selectedId {
					self.segmentControl.selectedSegmentIndex = counter
					if let text = item.data?.variants?[counter].text {
						self.textLable.text = text
					}
				}
			}
		}
	}

	func setLevel() {
		let number = self.segmentControl.selectedSegmentIndex
		self.textLable.text = datum?.data?.variants?[number].text
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

	// MARK: Delegate methods

	@objc func handleValueChange() {
		setLevel()
		delegate?.changeValue(segment: self.segmentControl.selectedSegmentIndex)
	}

}
