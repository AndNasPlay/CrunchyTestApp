//
//  DataListViewModel.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit
import RxSwift
import Kingfisher

protocol DataListViewModelProtocol {
	func alert(message: String)
	func didSelectRow(at indexPath: IndexPath)
	func fetchData()
	func createCells(add element: Datum, for table: UITableView) -> UITableViewCell
}

final class DataListViewModel: DataListViewModelProtocol {

	var coordinator: DataListCoordinator?

	public let data = BehaviorSubject(value: [Datum]())

	private var tableViewArr: [Datum] = []

	public var activeSegment: Int = 0

	private let networkManager = NetworkManager.shared

	func fetchData() {
		networkManager.getData { [weak self] (result, error) in
			guard let self = self else { return }
			if error != nil {
				self.alert(message: error!.localizedDescription)
			} else {
				guard var model = result?.data else { self.alert(message: "Data is empty"); return }
				guard let views = result?.view else { self.alert(message: "Views is empty"); return }
				views.forEach { view in
					for counter in 0..<model.count {
						if view == model[counter].name {
							self.tableViewArr.append(model[counter])
							model.remove(at: counter)
							break
						}
					}
				}
				self.data.on(.next(self.tableViewArr))
			}
		}
	}

	func createCells(add element: Datum, for table: UITableView) -> UITableViewCell {
		if element.name == "hz" {
			return makeTextCell(with: element, from: table)
		} else if element.name == "picture" {
			return makeImageCell(with: element, from: table)
		} else if element.name == "selector" {
			return makeSelectorCell(with: element, from: table)
		} else {
			return makeDefaultCell(for: table)
		}
	}

	private func makeTextCell(with element: Datum, from table: UITableView) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = table.dequeueReusableCell(withIdentifier: TextTableViewCell().identifier) as! TextTableViewCell
		// swiftlint:enable force_cast
		cell.configureCell(item: element)
		return cell
	}

	private func makeImageCell(with element: Datum, from table: UITableView) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = table.dequeueReusableCell(withIdentifier: ImageTableViewCell().identifier) as! ImageTableViewCell
		// swiftlint:enable force_cast
		cell.configureCell(item: element)
		let imgUrl: URL = URL(string: (element.data?.url)!)!
		cell.mainImageView.kf.setImage(with: imgUrl)
		return cell
	}

	private func makeSelectorCell(with element: Datum, from table: UITableView) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = table.dequeueReusableCell(withIdentifier: SelectorTableViewCell().identifier) as! SelectorTableViewCell
		// swiftlint:enable force_cast
		cell.configureCell(item: element)
		cell.delegate = coordinator?.dataListViewController
		self.activeSegment = (element.data?.selectedID ?? 1)
		return cell
	}

	private func makeDefaultCell(for table: UITableView) -> UITableViewCell {
		// swiftlint:disable force_cast
		let cell = table.dequeueReusableCell(withIdentifier: DefaultTableViewCell().identifier) as! DefaultTableViewCell
		// swiftlint:enable force_cast
		return cell
	}

	func alert(message: String) {
		coordinator?.getInfo(message: message, name: "Error")
	}

	func didSelectRow(at indexPath: IndexPath) {
		let name = tableViewArr[indexPath.row].name ?? "name"
		let message = tableViewArr[indexPath.row].data?.text ?? "message"
		if message == "message" {
			coordinator?.getInfo(message: "Active segment number \(self.activeSegment)", name: name)
		} else {
			coordinator?.getInfo(message: message, name: name)
		}
	}
}
