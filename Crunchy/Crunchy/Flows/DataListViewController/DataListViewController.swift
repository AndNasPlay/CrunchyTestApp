//
//  DataListViewController.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class DataListViewController: UIViewController {

	var viewModel: DataListViewModel?

	private var disposeBag = DisposeBag()

	// swiftlint:disable force_cast
	private var dataListView: DataListView {
		return self.view as! DataListView
	}
	// swiftlint:enable force_cast

	override func viewDidLoad() {
		super.viewDidLoad()
		updateMainView()
		viewModel?.fetchRates()
		bindTableView()
	}

	private func updateMainView() {
		self.view = DataListView()
	}

	func bindTableView() {
		//		dataListView.tableView.rx.setDelegate(self).disposed(by: disposeBag)

		viewModel?.data.bind(to: dataListView.tableView.rx.items) { [weak self] table, _, element in
			if element.name == "hz" {
				return (self?.viewModel?.makeTextCell(with: element, from: table))!
			} else if element.name == "picture" {
				return (self?.viewModel?.makeImageCell(with: element, from: table))!
			} else {
				return (self?.viewModel?.makeSelectorCell(with: element, from: table))!
			}
		}.disposed(by: disposeBag)
	}

	@objc func handleFromDateSelectedValueChanged() { }
}

extension DataListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//		self.viewModel?.didSelectRow(at: indexPath)
	}
}
