//
//  UIButtonExtension .swift
//  Crunchy
//
//  Created by Андрей Щекатунов on 25.08.2022.
//

import UIKit

extension UIButton {

	func applyGradient(colors: [CGColor]) {
		self.backgroundColor = nil
		self.layoutIfNeeded()
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = colors
		gradientLayer.startPoint = CGPoint(x: 0, y: 0)
		gradientLayer.endPoint = CGPoint(x: 1, y: 0)
		gradientLayer.frame = self.bounds
		gradientLayer.cornerRadius = self.frame.height / 4

		gradientLayer.shadowColor = UIColor.darkGray.cgColor
		gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
		gradientLayer.shadowRadius = 5.0
		gradientLayer.shadowOpacity = 0.3
		gradientLayer.masksToBounds = false

		self.layer.insertSublayer(gradientLayer, at: 0)
		self.contentVerticalAlignment = .center
	}

}
