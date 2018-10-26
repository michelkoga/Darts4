//
//  KeyboardButton.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/08.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class KeyboardButton: UIButton {
	
    override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		self.layer.cornerRadius = 0.1 * self.bounds.size.width // See line below
		self.clipsToBounds = true // Needed for corner radius work.
		
        self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
		self.setTitleColor(UIColor.lightGray, for: .normal)
		self.setTitleColor(UIColor.white, for: .highlighted)
    }
}
class notNumberButton: KeyboardButton {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		self.addTarget(self, action: #selector(self.handleTapDown(sender:)), for: .touchDown)
		self.addTarget(self, action: #selector(self.handleTapUp(sender:)), for: [.touchUpInside, .touchUpOutside])

	}
	@objc func handleTapDown(sender: KeyboardButton) {
		sender.backgroundColor = #colorLiteral(red: 0.3823844194, green: 0.3823844194, blue: 0.3823844194, alpha: 1)
	}
	@objc func handleTapUp(sender: KeyboardButton) {
		sender.backgroundColor = #colorLiteral(red: 0.2599999905, green: 0.2599999905, blue: 0.2599999905, alpha: 1)
	}
}

class BigButton: notNumberButton {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 30)
		
	}
}
class NumberButton: KeyboardButton {
	@IBInspectable var number: Int = 0
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 40)
		self.backgroundColor = UIColor.gray
		
		
		self.setBackgroundColor(color: #colorLiteral(red: 0.1299999952, green: 0.1299999952, blue: 0.1299999952, alpha: 1), forState: .disabled)
		self.setBackgroundColor(color: #colorLiteral(red: 0.1299999952, green: 0.1299999952, blue: 0.1299999952, alpha: 1), forState: .normal)
		
		self.addTarget(self, action: #selector(self.handleTapDown(sender:)), for: .touchDown)
		self.addTarget(self, action: #selector(self.handleTapUp(sender:)), for: [.touchUpInside, .touchUpOutside])
	}
	@objc func handleTapDown(sender: KeyboardButton) {
		sender.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
	}
	@objc func handleTapUp(sender: KeyboardButton) {
		sender.backgroundColor = #colorLiteral(red: 0.1299999952, green: 0.1299999952, blue: 0.1299999952, alpha: 1)
	}
	func setBackgroundColor(color: UIColor, forState: UIControl.State) {
		
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
		UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let colorImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		
		self.setBackgroundImage(colorImage, for: forState)
	}
}
class BiggestButton: UIButton {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		self.layer.cornerRadius = 0.05 * self.bounds.size.width // See line below
		self.clipsToBounds = true // Needed for corner radius work
		
	}
	
}
class ShowKeyboardButton: UIButton {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		self.layer.cornerRadius = 0.1 * self.bounds.size.width // See line below
		self.clipsToBounds = true // Needed for corner radius work
		
	}
}
