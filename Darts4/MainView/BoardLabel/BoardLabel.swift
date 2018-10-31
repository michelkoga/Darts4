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
	weak var shapeLayer: CAShapeLayer?
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		////
		
		
		////
		
		var minBestScore = 50
		if UserDefaults.standard.contains(key: "minNiceValue") {
			minBestScore = UserDefaults.standard.integer(forKey: "minNiceValue")
		}
		
		if self.text != "" {
			if Int(self.text!) != nil {
				if Int(self.text!)! >= minBestScore {
					self.drawCircle()
				}
			}
		}
	}
	
	var currentAngle:Float = -90
	
	let timeBetweenDraw:CFTimeInterval = 0.01
	
	// MARK: Init
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	func setup() {
		self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
		Timer.scheduledTimer(timeInterval: timeBetweenDraw, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
	}
	
	// MARK: Drawing
	@objc func updateTimer() {
		
		if currentAngle < 270 {
			currentAngle += 1
			setNeedsDisplay()
		}
	}
	func drawAnimatedEllipse3() {
		//
		let width = self.frame.width
		let height = self.frame.height
		
		let pointLeft = CGPoint(x: 0, y: height / 2)
		let pointUp = CGPoint(x: width / 2, y: 0)
		let pointRight = CGPoint(x: width, y: height / 2)
		let pointDown = CGPoint(x: width / 2, y: height)
		
		let upLeft = CGPoint(x: 0, y: 0)
		let upRight = CGPoint(x: width, y: 0)
		let downRight = CGPoint(x: width, y: height)
		let downLeft = CGPoint(x: 0, y: height)
		
		let context = UIGraphicsGetCurrentContext()
		context?.setLineWidth(3.0)
		context?.setStrokeColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))    // make circle rect 5 px from border
		var circleRect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
		circleRect = circleRect.insetBy(dx: 2, dy: 2)
		
		// draw circle
		context?.move(to: pointLeft)
		context?.addQuadCurve(to: pointUp, control: upLeft)
		context?.addQuadCurve(to: pointRight, control: upRight)
		context?.addQuadCurve(to: pointDown, control: downRight)
		context?.addQuadCurve(to: pointLeft, control: downLeft)
		
		context?.strokePath()
	}
	func drawAnimatedEllipse2() {
		let context = UIGraphicsGetCurrentContext()
		
		let path = CGMutablePath()
		path.addRoundedRect(in: self.frame, cornerWidth: self.frame.width, cornerHeight: self.frame.height)
//		CGPathAddArc(path, nil, 20, 10, 20, 0, .pi, false)
		
		context!.addPath(path)
		context!.setStrokeColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
//		CGContextSetStrokeColorWithColor(context!, UIColor.blue.CGColor)
		context!.setLineWidth(3)
		context!.strokePath()
	}
	
	func drawAnimatedEllipse() {
		let width = self.frame.width
		let height = self.frame.height
		// create whatever path you want
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 10, y: 50))
		path.addArc(withCenter: CGPoint(x: width / 2, y: height / 2), radius: height / 2, startAngle: 0.0, endAngle: 1.0, clockwise: true)
		path.addCurve(to: CGPoint(x: 20, y: 20), controlPoint1: CGPoint(x: 5, y: -10), controlPoint2: CGPoint(x: 10, y: 30))

		
		// create shape layer for that path
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
		shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
		shapeLayer.lineWidth = 4
		shapeLayer.path = path.cgPath
		
		// animate it
		
		self.layer.addSublayer(shapeLayer)
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.fromValue = 0
		animation.duration = 2
		shapeLayer.add(animation, forKey: "MyAnimation")
		
		// save shape layer
		
		self.shapeLayer = shapeLayer
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
	
	func drawCross() {
		let cross = UIGraphicsGetCurrentContext()
		cross?.setLineCap(.round)
		cross?.setLineWidth(3.0)
		cross?.setStrokeColor(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))
		cross?.move(to: CGPoint(x: 0, y: 0))
		cross?.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
		cross?.move(to: CGPoint(x: self.frame.width, y: 0))
		cross?.addLine(to: CGPoint(x: 0, y: self.frame.height))
		cross?.strokePath()
	}
	
}
class CrossedLabel: BoardLabel, Cross {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		drawCross()
	}
	func drawCross() {
		let cross = UIGraphicsGetCurrentContext()
		cross?.setLineCap(.round)
		cross?.setLineWidth(3.0)
		cross?.setStrokeColor(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))
		cross?.move(to: CGPoint(x: 0, y: 0))
		cross?.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
		cross?.move(to: CGPoint(x: self.frame.width, y: 0))
		cross?.addLine(to: CGPoint(x: 0, y: self.frame.height))
		cross?.strokePath()
	}
	
	
}

class TurnNumber: BoardLabel {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
	}
}

protocol Cross {
	func drawCross()
}
