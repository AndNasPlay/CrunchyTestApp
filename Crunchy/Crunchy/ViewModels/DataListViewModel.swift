//
//  DataListViewModel.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit
import RxSwift

final class DataListViewModel {

	let title = "Cranchy"

	var coordinator: DataListCoordinator?

	public let data = BehaviorSubject(value: [Datum]())

	private let networkManager = NetworkManager.shared

	var alertMessage: String = ""

	func fetchRates() {

		networkManager.getData { [weak self] (result, error) in
			guard let self = self else { return }
			guard let model = result?.data else { self.alertMessage = error?.localizedDescription ?? ""; return }
			guard let views = result?.view else { self.alertMessage = error?.localizedDescription ?? ""; return }
			var tableViewArr: [Datum] = []
			views.forEach { view in
				for counter in 0..<model.count {
					if view == model[counter].name {
						tableViewArr.append(model[counter])
						break
					}
				}
			}
			self.data.on(.next(tableViewArr))
		}
	}

	func makeTextCell(with element: Datum, from table: UITableView) -> UITableViewCell {
		// swiftlint:disable force_cast
	  let cell = table.dequeueReusableCell(withIdentifier: "textTableViewCell") as! TextTableViewCell
		// swiftlint:enable force_cast
		cell.configureCell(item: element)
	  return cell
	}

	func makeImageCell(with element: Datum, from table: UITableView) -> UITableViewCell {
		// swiftlint:disable force_cast
	  let cell = table.dequeueReusableCell(withIdentifier: "imageTableViewCell") as! ImageTableViewCell
		// swiftlint:enable force_cast
		cell.configureCell(item: element)
	  return cell
	}

	func makeSelectorCell(with element: Datum, from table: UITableView) -> UITableViewCell {
		// swiftlint:disable force_cast
	  let cell = table.dequeueReusableCell(withIdentifier: "selectorTableViewCell") as! SelectorTableViewCell
		// swiftlint:enable force_cast
		cell.configureCell(item: element)
	  return cell
	}

	func didSelectRow(at indexPath: IndexPath) {

	}

	func getInfo() {
		coordinator?.getInfo(message: alertMessage)
	}

}
