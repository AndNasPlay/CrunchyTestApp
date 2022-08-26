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

	override func loadView() {
		super.loadView()
		self.view = DataListView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel?.fetchData()
		bindTableView()
	}

	func bindTableView() {
		dataListView.tableView.rx.setDelegate(self).disposed(by: disposeBag)

		viewModel?.data.bind(to: dataListView.tableView.rx.items) { [weak self] table, _, element in
			return (self?.viewModel?.createCells(add: element, for: table)) ?? UITableViewCell()
		}.disposed(by: disposeBag)
	}

}

extension DataListViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.viewModel?.didSelectRow(at: indexPath)
	}
}

extension DataListViewController: SelectorTableViewCellDelegate {
	func changeValue(segment: Int) {
		self.viewModel?.activeSegment = segment + 1
	}
}
