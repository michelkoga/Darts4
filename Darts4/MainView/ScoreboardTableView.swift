//
//  ScoreboardTableView.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/09.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class ScoreboardTableView: UITableView {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		//self.setGradientBackground(colorOne: .blue, colorTwo: .green)
		
		
		// MARK: Vertical white lines
//		let upCenterLeft = CGPoint(x: ((self.bounds.width/2) - 30), y: 3)
//		let upCenterRight = CGPoint(x: ((self.bounds.width/2) + 30), y: 3)
//
//		let downCenterLeft = CGPoint(x: ((self.bounds.width/2) - 30), y: self.bounds.height * 2)
//		let downCenterRight = CGPoint(x: ((self.bounds.width/2) + 30), y: self.bounds.height * 2)
//		
//		let context = UIGraphicsGetCurrentContext()
//		context?.setLineWidth(5.0)
//		context?.setStrokeColor(UIColor.white.cgColor)
//		context?.move(to: upCenterLeft)
//		context?.addLine(to: downCenterLeft)
//		context?.move(to: upCenterRight)
//		context?.addLine(to: downCenterRight)
//		
//		context?.strokePath()
		
		
		// MARK: Subtle Lines:
//		let scoreALeftUp = CGPoint(x: ((self.bounds.midX/2) - 75), y: 4)
//		let scoreALeftDown = CGPoint(x: ((self.bounds.midX/2) - 75), y: self.bounds.height)
		if self.layer.bounds.width > 760.0 {
			//		print(self.layer.bounds.width)
			let scoreARightUP = CGPoint(x: ((self.bounds.midX/2) + 40), y: 4)
			let scoreARightDown = CGPoint(x: ((self.bounds.midX/2) + 40), y: self.bounds.height)
			
			let scoreBLeftUp = CGPoint(x: (((self.bounds.midX/2) * 3) - 30), y: 4)
			let scoreBLeftDown = CGPoint(x: (((self.bounds.midX/2) * 3) - 30), y: self.bounds.height)
			
			//		let scoreBRightUP = CGPoint(x: (((self.bounds.midX/2) * 3) + 70), y: 4)
			//		let scoreBRightDown = CGPoint(x: (((self.bounds.midX/2) * 3) + 70), y: self.bounds.height)
			
			let subtleLines = UIGraphicsGetCurrentContext()
			subtleLines?.setLineWidth(4)
			subtleLines?.setStrokeColor(#colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1))
			//		subtleLines?.move(to: scoreALeftUp)
			//		subtleLines?.addLine(to: scoreALeftDown)
			subtleLines?.move(to: scoreARightUP)
			subtleLines?.addLine(to: scoreARightDown)
			subtleLines?.move(to: scoreBLeftUp)
			subtleLines?.addLine(to: scoreBLeftDown)
			//		subtleLines?.move(to: scoreBRightUP)
			//		subtleLines?.addLine(to: scoreBRightDown)
			
			subtleLines?.strokePath()
		}
		
	}
	
}
class HeaderView: UIView {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		// Horizontal White Line on Header:
		let context = UIGraphicsGetCurrentContext()
		context?.setLineWidth(5.0)
		context?.setStrokeColor(UIColor.white.cgColor)
		context?.move(to: CGPoint(x:0, y: 47))
		
		context?.addLine(to: CGPoint(x: self.bounds.width, y: 47))
		
		context?.strokePath()
		
		// Subtle Lines:
		
//		if self.layer.bounds.width > 760.0 {
//			let scoreARightUP = CGPoint(x: ((self.bounds.midX/2) + 40), y: 10)
//			let scoreARightDown = CGPoint(x: ((self.bounds.midX/2) + 40), y: 57)
//
//			let scoreBLeftUp = CGPoint(x: (((self.bounds.midX/2) * 3) - 30), y: 10)
//			let scoreBLeftDown = CGPoint(x: (((self.bounds.midX/2) * 3) - 30), y: 57)
//
//			let subtleLines = UIGraphicsGetCurrentContext()
//			subtleLines?.setLineWidth(4)
//			subtleLines?.setStrokeColor(#colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1))
//
//			subtleLines?.move(to: scoreARightUP)
//			subtleLines?.addLine(to: scoreARightDown)
//			subtleLines?.move(to: scoreBLeftUp)
//			subtleLines?.addLine(to: scoreBLeftDown)
//
//			subtleLines?.strokePath()
//		}
		
	}
}
extension UIView {
	
	func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 1.0, y: 2.5)
		
		layer.insertSublayer(gradientLayer, at: 0)
	}
}
