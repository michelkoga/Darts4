//
//  FooterView.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/28.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class FooterView: UIView {

	
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
		
		// Horizontal White Line on Footer:
		let context = UIGraphicsGetCurrentContext()
		context?.setLineWidth(5.0)
		context?.setStrokeColor(UIColor.white.cgColor)
		context?.move(to: CGPoint(x:0, y: 47))
		
		context?.addLine(to: CGPoint(x: self.bounds.width, y: 47))
		
		context?.strokePath()
    }
	

}
