//
//  Coordinator.swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import Foundation

protocol Coordinator: AnyObject {
	var childCoordinators: [Coordinator] { get }
	func start()
	func childDidFinish(_ childCoordinator: Coordinator)
}
