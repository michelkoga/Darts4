//
//  StatsViewController.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/22.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class StatsViewController: MotherViewController {

	@IBOutlet weak var nameCell: UILabel!
	override func viewDidLoad() {
        super.viewDidLoad()

    }
	override func viewWillAppear(_ animated: Bool) {
		//nameCell.text = String(allPlayersDataSelectedRow) // Always Zero 0!!
		//print("stats viewWillApear")
	}
    

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		print("Navigation")
    }


}
