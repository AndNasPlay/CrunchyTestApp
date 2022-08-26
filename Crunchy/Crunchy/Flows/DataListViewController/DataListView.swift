//
//  DataListView.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

final class DataListView: UIView {

	// MARK: Variables

	let textCellIdentifier = TextTableViewCell().identifier
	let imageCellIdentifier = ImageTableViewCell().identifier
	let selectorTableViewCell = SelectorTableViewCell().identifier

	// MARK: - Subviews

	private(set) lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(TextTableViewCell.self, forCellReuseIdentifier: textCellIdentifier)
		tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: imageCellIdentifier)
		tableView.register(SelectorTableViewCell.self, forCellReuseIdentifier: selectorTableViewCell)
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		return tableView
	}()

	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureUI()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureUI()
	}

	private func configureUI() {
		self.backgroundColor = .white
		self.addTableView()
		self.setupConstraints()
	}

	private func addTableView() {
		self.tableView.rowHeight = UITableView.automaticDimension
		self.addSubview(tableView)
	}

	// MARK: - Constraints init

	private func setupConstraints() {
		let safeArea = self.safeAreaLayoutGuide

		NSLayoutConstraint.activate([
			self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
			self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}

}
