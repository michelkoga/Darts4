//
//  BoardLabel.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/08.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit
import GLKit

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
	
	var animateThis = false
//	var shapeLayer: CAShapeLayer?
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
	func removeAnimation() {
		self.layer.removeAllAnimations()
	}
	func fixEllipse() {// change 2 to desired number of seconds
		
		let width = self.frame.width
		let height = self.frame.height
		//
		
		let pointLeft = CGPoint(x: 2, y: height / 2)
		let pointUp = CGPoint(x: width / 2, y: 2)
		let pointRight = CGPoint(x: width - 2, y: height / 2)
		let pointDown = CGPoint(x: width / 2, y: height - 2)
		
		let upLeft2 = CGPoint(x: 5, y: 5)
		let upRight2 = CGPoint(x: width - 5, y: 5)
		let downRight2 = CGPoint(x: width - 5, y: height - 5)
		let downLeft2 = CGPoint(x: 5, y: height - 5)
		// create whatever path you want
		
		let path = UIGraphicsGetCurrentContext()
		path?.setStrokeColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
		path?.setLineWidth(3.0)
		path?.move(to: pointLeft)
		// draw circle
		path?.addQuadCurve(to: pointUp, control: upLeft2)
		path?.addQuadCurve(to: pointRight, control: upRight2)
		path?.addQuadCurve(to: pointDown, control: downRight2)
		path?.addQuadCurve(to: pointLeft, control: downLeft2)
		path?.strokePath()
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
		context?.strokePath()
		usleep(5000)
		context?.addQuadCurve(to: pointRight, control: upRight)
		context?.strokePath()
		usleep(500)
		context?.addQuadCurve(to: pointDown, control: downRight)
		context?.strokePath()
		usleep(500)
		context?.addQuadCurve(to: pointLeft, control: downLeft)
		usleep(500)
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
	func nicePoint() {
		let path = UIBezierPath()
		
		// Apple
		path.move(to: CGPoint(x: 110.89, y: 99.2))
		path.addCurve(to: CGPoint(x: 105.97, y: 108.09), controlPoint1: CGPoint(x: 109.5, y: 102.41), controlPoint2: CGPoint(x: 107.87, y: 105.37))
		path.addCurve(to: CGPoint(x: 99.64, y: 115.79), controlPoint1: CGPoint(x: 103.39, y: 111.8), controlPoint2: CGPoint(x: 101.27, y: 114.37))
		path.addCurve(to: CGPoint(x: 91.5, y: 119.4), controlPoint1: CGPoint(x: 97.11, y: 118.13), controlPoint2: CGPoint(x: 94.4, y: 119.33))
		path.addCurve(to: CGPoint(x: 83.99, y: 117.59), controlPoint1: CGPoint(x: 89.42, y: 119.4), controlPoint2: CGPoint(x: 86.91, y: 118.8))
		path.addCurve(to: CGPoint(x: 75.9, y: 115.79), controlPoint1: CGPoint(x: 81.06, y: 116.39), controlPoint2: CGPoint(x: 78.36, y: 115.79))
		path.addCurve(to: CGPoint(x: 67.58, y: 117.59), controlPoint1: CGPoint(x: 73.31, y: 115.79), controlPoint2: CGPoint(x: 70.54, y: 116.39))
		path.addCurve(to: CGPoint(x: 60.39, y: 119.49), controlPoint1: CGPoint(x: 64.61, y: 118.8), controlPoint2: CGPoint(x: 62.21, y: 119.43))
		path.addCurve(to: CGPoint(x: 52.07, y: 115.79), controlPoint1: CGPoint(x: 57.6, y: 119.61), controlPoint2: CGPoint(x: 54.83, y: 118.38))
		path.addCurve(to: CGPoint(x: 45.44, y: 107.82), controlPoint1: CGPoint(x: 50.3, y: 114.24), controlPoint2: CGPoint(x: 48.09, y: 111.58))
		path.addCurve(to: CGPoint(x: 38.44, y: 93.82), controlPoint1: CGPoint(x: 42.6, y: 103.8), controlPoint2: CGPoint(x: 40.27, y: 99.14))
		path.addCurve(to: CGPoint(x: 35.5, y: 77.15), controlPoint1: CGPoint(x: 36.48, y: 88.09), controlPoint2: CGPoint(x: 35.5, y: 82.53))
		path.addCurve(to: CGPoint(x: 39.48, y: 61.21), controlPoint1: CGPoint(x: 35.5, y: 70.98), controlPoint2: CGPoint(x: 36.82, y: 65.67))
		path.addCurve(to: CGPoint(x: 47.8, y: 52.74), controlPoint1: CGPoint(x: 41.56, y: 57.63), controlPoint2: CGPoint(x: 44.33, y: 54.81))
		path.addCurve(to: CGPoint(x: 59.06, y: 49.54), controlPoint1: CGPoint(x: 51.27, y: 50.67), controlPoint2: CGPoint(x: 55.02, y: 49.61))
		path.addCurve(to: CGPoint(x: 67.76, y: 51.58), controlPoint1: CGPoint(x: 61.27, y: 49.54), controlPoint2: CGPoint(x: 64.16, y: 50.23))
		path.addCurve(to: CGPoint(x: 74.67, y: 53.62), controlPoint1: CGPoint(x: 71.35, y: 52.94), controlPoint2: CGPoint(x: 73.66, y: 53.62))
		path.addCurve(to: CGPoint(x: 82.33, y: 51.22), controlPoint1: CGPoint(x: 75.42, y: 53.62), controlPoint2: CGPoint(x: 77.98, y: 52.82))
		path.addCurve(to: CGPoint(x: 92.73, y: 49.36), controlPoint1: CGPoint(x: 86.43, y: 49.73), controlPoint2: CGPoint(x: 89.9, y: 49.12))
		path.addCurve(to: CGPoint(x: 110.05, y: 58.53), controlPoint1: CGPoint(x: 100.43, y: 49.98), controlPoint2: CGPoint(x: 106.2, y: 53.03))
		path.addCurve(to: CGPoint(x: 99.83, y: 76.13), controlPoint1: CGPoint(x: 103.17, y: 62.72), controlPoint2: CGPoint(x: 99.77, y: 68.59))
		path.addCurve(to: CGPoint(x: 106.17, y: 90.76), controlPoint1: CGPoint(x: 99.89, y: 82), controlPoint2: CGPoint(x: 102.01, y: 86.88))
		path.addCurve(to: CGPoint(x: 112.5, y: 94.94), controlPoint1: CGPoint(x: 108.05, y: 92.56), controlPoint2: CGPoint(x: 110.16, y: 93.95))
		path.addCurve(to: CGPoint(x: 110.89, y: 99.2), controlPoint1: CGPoint(x: 111.99, y: 96.42), controlPoint2: CGPoint(x: 111.46, y: 97.84))
		
		// Leaf
		path.move(to: CGPoint(x: 93.25, y: 29.36))
		path.addCurve(to: CGPoint(x: 88.25, y: 42.23), controlPoint1: CGPoint(x: 93.25, y: 33.96), controlPoint2: CGPoint(x: 91.58, y: 38.26))
		path.addCurve(to: CGPoint(x: 74.1, y: 49.26), controlPoint1: CGPoint(x: 84.23, y: 46.96), controlPoint2: CGPoint(x: 79.37, y: 49.69))
		path.addCurve(to: CGPoint(x: 74, y: 47.52), controlPoint1: CGPoint(x: 74.03, y: 48.71), controlPoint2: CGPoint(x: 74, y: 48.13))
		path.addCurve(to: CGPoint(x: 79.3, y: 34.51), controlPoint1: CGPoint(x: 74, y: 43.1), controlPoint2: CGPoint(x: 75.91, y: 38.38))
		path.addCurve(to: CGPoint(x: 85.76, y: 29.63), controlPoint1: CGPoint(x: 80.99, y: 32.55), controlPoint2: CGPoint(x: 83.15, y: 30.93))
		path.addCurve(to: CGPoint(x: 93.15, y: 27.52), controlPoint1: CGPoint(x: 88.37, y: 28.35), controlPoint2: CGPoint(x: 90.83, y: 27.65))
		path.addCurve(to: CGPoint(x: 93.25, y: 29.36), controlPoint1: CGPoint(x: 93.22, y: 28.14), controlPoint2: CGPoint(x: 93.25, y: 28.75))
		path.addLine(to: CGPoint(x: 93.25, y: 29.36))
		
		path.close()
		
		// Create shape layer and add the path to it
		let layer = CAShapeLayer()
		layer.path = path.cgPath
		
		// Set up the appearance of the shape layer
		layer.strokeEnd = 0
		layer.lineWidth = 1
		layer.strokeColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
		layer.fillColor = UIColor.clear.cgColor
		
		// Create view and set its appearance
		let animateView = UIView(frame: CGRect(x: 40, y: 100, width: 150, height: 150))
		animateView.backgroundColor = .clear
		// Add the shape layer to view
		self.layer.addSublayer(layer)
		
		// Create the animation for the shape view
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.toValue = 1
		animation.duration = 2 // seconds
		animation.autoreverses = true
		animation.repeatCount = .infinity
		
		// And finally add the linear animation to the shape!
		animateView.layer.add(animation, forKey: "line")
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
