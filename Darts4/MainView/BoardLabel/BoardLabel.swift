//
//  BoardLabel.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/08.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class BoardLabel: UILabel {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		//		self.textColor = #colorLiteral(red: 0.9702662826, green: 0.9211027026, blue: 0.6305727363, alpha: 1)
		
	}
	
}

class turnLabel: BoardLabel {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		let verticalLine = UIGraphicsGetCurrentContext()
		verticalLine?.setLineWidth(5.0)
		verticalLine?.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
		verticalLine?.move(to: CGPoint(x:3, y: 0))
		verticalLine?.addLine(to: CGPoint(x: 3, y: self.layer.frame.height))
		
		verticalLine?.move(to: CGPoint(x: self.layer.frame.width - 3, y: 0))
		verticalLine?.addLine(to: CGPoint(x: self.layer.frame.width - 3, y: self.layer.frame.height))
		
		verticalLine?.strokePath()
		self.setNeedsDisplay()
		
	}
}
class ScoreLabel: BoardLabel {
	let circleLayer = CAShapeLayer()
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		//		if (self.text?.count)! > 3 {
		//			let text = String((self.text?.dropLast())!)
		//			self.text = text
		//		}
//		self.layer.cornerRadius = 10
//		self.layer.borderWidth = 3.0
		var minBestScore = 50
		if UserDefaults.standard.contains(key: "minNiceValue") {
			minBestScore = UserDefaults.standard.integer(forKey: "minNiceValue")
		}
		if self.text != "" {
			if Int(self.text!) != nil {
				if Int(self.text!)! >= minBestScore {
					self.drawCircle()
					//				self.addCircleView()
				}
			}
		}
		
		let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
		
		// Setup the CAShapeLayer with the path, colors, and line width
		//		circleLayer = CAShapeLayer()
		circleLayer.path = circlePath.cgPath
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.strokeColor = UIColor.red.cgColor
		circleLayer.lineWidth = 5.0;
		
		// Don't draw the circle initially
		circleLayer.strokeEnd = 0.0
		
		// Add the circleLayer to the view's layer's sublayers
		layer.addSublayer(circleLayer)
		
		
		
		
		
	}
	
	
	
	func drawCircle() {
		let context = UIGraphicsGetCurrentContext()
		context?.setLineWidth(3.0)
		context?.setStrokeColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))    // make circle rect 5 px from border
		var circleRect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
		circleRect = circleRect.insetBy(dx: 2, dy: 2)
		
		// draw circle
		context?.strokeEllipse(in: circleRect)
		
		context?.strokePath()
		
		
		
	}
	
}
class TurnNumber: BoardLabel {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
	}
}
