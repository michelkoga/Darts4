//
//  FooterLabels.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/27.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class FooterLabels: UILabel {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		let horizontalLine = UIGraphicsGetCurrentContext()
		horizontalLine?.setLineWidth(3.0)
		horizontalLine?.setStrokeColor(#colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1))
		horizontalLine?.move(to: CGPoint(x:10, y: 2))
		
		horizontalLine?.addLine(to: CGPoint(x: self.bounds.width - 10, y: 2))
		
		horizontalLine?.strokePath()
		self.setNeedsDisplay()
	}
}
