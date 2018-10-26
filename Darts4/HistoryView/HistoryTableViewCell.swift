//
//  HistoryTableViewCell.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/17.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var gamesLabel: UILabel!
	@IBOutlet weak var winLabel: UILabel!
	@IBOutlet weak var scoreAverageLabel: UILabel!
	@IBOutlet weak var showStatsButton: UIButton!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		
	}

	
}

