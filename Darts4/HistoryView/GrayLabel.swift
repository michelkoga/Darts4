//
//  GrayLabel.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/26.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class GrayLabel: UILabel {

	
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
		super.draw(rect)
        self.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
	

}
