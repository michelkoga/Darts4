//
//  TableViewConroller.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/24.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit


extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sets.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let set = sets[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell") as! ScoresCell
//		// Make plaid:
//		if indexPath.row % 2 == 0 {
//			cell.scoreA.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//			cell.setNumber.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//			cell.toGoB.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//
//			cell.playerA.backgroundColor = #colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1)
//			cell.toGoA.backgroundColor = #colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1)
//			cell.scoreB.backgroundColor = #colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1)
//			cell.playerB.backgroundColor = #colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1)
//		} else {
//			cell.scoreA.backgroundColor = #colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1)
//			cell.setNumber.backgroundColor = #colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1)
//			cell.toGoB.backgroundColor = #colorLiteral(red: 0.08857408911, green: 0.08857408911, blue: 0.08857408911, alpha: 1)
//
//			cell.playerA.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//			cell.toGoA.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//			cell.scoreB.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//			cell.playerB.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//		}
		// Make transparent:
		if indexPath.row % 2 == 0 {
			cell.scoreA.backgroundColor = UIColor.clear
			cell.setNumber.backgroundColor = UIColor.clear
			cell.toGoB.backgroundColor = UIColor.clear
			
			cell.playerA.backgroundColor = UIColor.clear
			cell.toGoA.backgroundColor = UIColor.clear
			cell.scoreB.backgroundColor = UIColor.clear
			cell.playerB.backgroundColor = UIColor.clear
		} else {
			cell.scoreA.backgroundColor = UIColor.clear
			cell.setNumber.backgroundColor = UIColor.clear
			cell.toGoB.backgroundColor = UIColor.clear
			
			cell.playerA.backgroundColor = UIColor.clear
			cell.toGoA.backgroundColor = UIColor.clear
			cell.scoreB.backgroundColor = UIColor.clear
			cell.playerB.backgroundColor = UIColor.clear
		}
		// Restore Player text color:
		cell.playerA.textColor = #colorLiteral(red: 0.3332984447, green: 0.3333585262, blue: 0.3332856596, alpha: 1)
		cell.playerB.textColor = #colorLiteral(red: 0.3332984447, green: 0.3333585262, blue: 0.3332856596, alpha: 1)
		// Set turn colors:
		if indexPath.row % 2 == 0 {
			cell.setNumber.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
		} else {
			cell.setNumber.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
		}
		
		
		if indexPath.row == row && !isGameOver {
			switch teamTurn {
			case 0:
				cell.scoreA.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
				cell.playerA.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			case 1:
				cell.scoreB.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
				cell.playerB.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			default:
				break
			}
		}
		if indexPath.row == sets.count {
			if sets.last?.toGoA != "" {
			}
		}
		
		// Draw cross for non used cells:
		if indexPath.row == 0 {
			print("Drawing Cross")
			cell.scoreA.drawCross()
			cell.scoreB.drawCross()
		}
		cell.setSet(set: set)
		
		return cell
		
	}
	
}
