//
//  ScoreFooter.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/27.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

extension ScoreViewController {
	func setFooter() {
		footerALabel.text = "Team A"
		footerBLabel.text = "Team B"
	}
}
class FooterView: UIView {
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
	}
}
