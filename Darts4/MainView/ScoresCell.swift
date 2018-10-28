//
//  ScoresCell.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/08.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class ScoresCell: UITableViewCell {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
//		let selectedColorView = UIView()
//		selectedColorView.backgroundColor = UIColor.darkGray
//		self.selectedBackgroundView = selectedColorView
//		self.selectionStyle = .none
		
		
		if self.setNumber.tag == 99 {
			drawHorizontalLine()
//			if self.toGoA.text != "" {
//				drawACircle()
//			}
//			if self.scoreB.text != "" {
//				drawBCircle()
//			}
		}
		
	}
	func drawHorizontalLine() {
		let horizontalWhiteLine = UIGraphicsGetCurrentContext()
		horizontalWhiteLine?.setLineWidth(5.0)
		horizontalWhiteLine?.setStrokeColor(UIColor.white.cgColor)
		horizontalWhiteLine?.move(to: CGPoint(x:20, y: 3))
		
		horizontalWhiteLine?.addLine(to: CGPoint(x: self.bounds.width - 20, y: 3))
		
		horizontalWhiteLine?.strokePath()
	}
	func drawACircle() {
		
		let context = UIGraphicsGetCurrentContext()
		context?.setLineWidth(3.0)
		context?.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))    // make circle rect 5 px from border
		var circleRect = CGRect(x: self.toGoA.frame.minX, y: self.toGoA.frame.minY, width: self.toGoA .bounds.width, height: self.toGoA.bounds.height)
		circleRect = circleRect.insetBy(dx: 5, dy: 5)
		
		// draw circle
		context?.strokeEllipse(in: circleRect)
		
		context?.strokePath()
	}
	func drawBCircle() {
		
		let context = UIGraphicsGetCurrentContext()
		context?.setLineWidth(3.0)
		context?.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))    // make circle rect 5 px from border
		var circleRect = CGRect(x: self.scoreB.frame.minX, y: self.scoreB.frame.minY, width: self.scoreB.bounds.width, height: self.scoreB.bounds.height)
		circleRect = circleRect.insetBy(dx: 5, dy: 5)
		
		// draw circle
		context?.strokeEllipse(in: circleRect)
		
		context?.strokePath()
		
	}
	
	@IBOutlet weak var playerA: UILabel!
	@IBOutlet weak var playerB: UILabel!
	
	@IBOutlet weak var scoreA: UILabel!
	@IBOutlet weak var scoreB: UILabel!
	
	@IBOutlet weak var toGoA: UILabel!
	@IBOutlet weak var toGoB: UILabel!
	
	@IBOutlet weak var setNumber: UILabel!
	
	func setSet(set: Set) {
		playerA.text = set.playerA
		playerB.text = set.playerB
		
		scoreA.text = set.scoreA
		scoreB.text = set.scoreB
		
		toGoA.text = set.toGoA
		toGoB.text = set.toGoB
		
		setNumber.text = set.turnNumber
		
	}
}
