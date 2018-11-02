//
//  SetsManager.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/28.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

extension ScoreViewController {
	// 1 text Field Pointers
	func setNextScoreField() {
		// Last row case:
		func showCenterNearestDartsAlert() {
			let resetAlert = UIAlertController(title: "Select Winner", message: nil, preferredStyle: .alert)
			resetAlert.addAction(UIAlertAction(title: "Team A", style: .default, handler: { (action: UIAlertAction!) in
				setWinner(winner: "A")
			}))
			resetAlert.addAction(UIAlertAction(title: "Team B", style: .default, handler: { (action: UIAlertAction!) in
				setWinner(winner: "B")
			}))
			resetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
				self.oneStepBack()
			}))
			present(resetAlert, animated: true, completion: nil)
			func setWinner(winner: String) {
				switch winner {
				case "A":
					legsA += 1
				case "B":
					legsB += 1
				default:
					break
				}
				legWinner = winner
				numberOfDarts = String(row * 3)
//				gameStarted = true
//				isGameOver = true
				sets = updateTableView()
				setFinish(winner: winner)
				tableView.reloadData()
				
				hideKeyboard()
				showHiddenView()
			}
		}
		
		//
		if leg % 2 == 0 {
			if teamTurn == 1 {
				teamTurn = 0
				
				
			} else {
				if row < (turnsNumber - 1) {
					row += 1
				}
				else {
					showCenterNearestDartsAlert()
					return
				}
				teamTurn = 1
			}
		} else {
			if teamTurn == 0 {
				teamTurn = 1
			} else {
				if row < (turnsNumber - 1) {
					row += 1
				}
				else {
					showCenterNearestDartsAlert()
					return
				}
				teamTurn = 0
			}
		}
		inputHolder = ""
		
	}
	func askDartsNumber() {
		var maxScore = 90
		if defaults.contains(key: "maxScore") {
			maxScore = defaults.integer(forKey: "maxScore")
		}
		
		switch teamTurn {
		case 0:
			if toGoesA[row] == nil  { return }
			if toGoesA[row]! > maxScore  { return }
		case 1:
			if toGoesB[row] == nil  { return }
			if toGoesB[row]! > maxScore { return }
		default:
			break
			
		}
		let doubleAsk = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		doubleAsk.addAction(UIAlertAction(title: "One Dart", style: .default, handler: { (action: UIAlertAction!) in
			setNumberOfDarts(number: 1)
		}))
		doubleAsk.addAction(UIAlertAction(title: "Two Darts", style: .default, handler: { (action: UIAlertAction!) in
			setNumberOfDarts(number: 2)
		}))
		doubleAsk.addAction(UIAlertAction(title: "Three Darts", style: .default, handler: { (action: UIAlertAction!) in
			setNumberOfDarts(number: 3)
		}))
		doubleAsk.popoverPresentationController?.sourceView = self.view
		doubleAsk.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
		doubleAsk.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		present(doubleAsk, animated: true, completion: nil)
		
		//
		func setNumberOfDarts(number: Int) {
			gameStarted = true
			isGameOver = true
			switch teamTurn {
			case 0:
				finishA = number
				sets[row].toGoA = "X\(number)"
				scoresA[row] = toGoesA[row]
				legsA += 1
			case 1:
				finishB = number
				sets[row].toGoB = "X\(number)"
				scoresB[row] = toGoesB[row]
				legsB += 1
			default:
				break
			}
			sets = updateTableView()
			// Set Finish Number:numberOfDarts = String(row * 3)
			gameStarted = true
			isGameOver = true
			sets = updateTableView()
			setFinish()
			tableView.reloadData()
		}
	}
	func updateTableView() -> [Set] {
		var tempSets: [Set] = []
		 //Set the new header:
		let headerSet = Set.init(playerA: "", playerB: "", scoreA: "", scoreB: "", toGoA: String(startingToGo), toGoB: String(startingToGo), turnNumber: "0", isBurst: false, isLast: false)
		tempSets.append(headerSet)
		// Insert turn labels:
		var turn = 3
		for i in 1..<scoresA.count {
			var scoreA = ""
			var scoreB = ""
			if scoresA[i] != nil { scoreA = String(scoresA[i]!) }
			if scoresB[i] != nil { scoreB = String(scoresB[i]!) }
			switch stateA[i] {
			case 2:
				scoreA = "B"
			default:
				break
			}
			switch stateB[i] {
			case 2:
				scoreB = "B"
			default:
				break
			}
			
			var toGoA = ""
			var toGoB = ""
			if toGoesA[i + 1] != nil {
				toGoA = String(toGoesA[i + 1]!)
			}
			if toGoesB[i + 1] != nil { toGoB = String(toGoesB[i + 1]!) }
			
			let set = Set.init(playerA: "", playerB: "", scoreA: scoreA, scoreB: scoreB, toGoA: toGoA, toGoB: toGoB, turnNumber: String(turn), isBurst: false, isLast: false)
			tempSets.append(set)
			turn += 3
		}
		// Insert player Names:
		let indexA = playersA.count - 1
		var index = 1
		for i in 1..<scoresA.count {
			tempSets[i].playerA = playersA[index]
			tempSets[i].playerB = playersB[index]
			if index < indexA { index += 1 }
			else { index = 1 }
		}
//		// Add One More Set(Center):
//		let centerSet: Set = Set(playerA: "", playerB: "", scoreA: "", scoreB: "", toGoA: "", toGoB: "", turnNumber: "C", isBurst: false, isLast: false)
//		tempSets.append(centerSet)
		return tempSets
	}
	func setFinish() {
		print("setFinish()")
		if finishA != 0 { // A wins
			footerFinishALabel.text = "X\(finishA)"
			if leg % 2 != 0 { // odd legs
				footerALabel.text = "\((row - 1) * 3 + finishA)d"  // start A, A wins
				footerBLabel.text = "\((row - 1) * 3)d"
			} else {
				footerALabel.text = "\((row - 1) * 3 + finishA)d" // start B, A wins
				footerBLabel.text = "\((row) * 3)d"
			}
		} else if finishB != 0 {
			footerFinishBLabel.text = "X\(finishB)"
			if leg % 2 != 0 { // odd legs
				footerALabel.text = "\((row) * 3)d" // start A, B wins
				footerBLabel.text = "\((row - 1) * 3 + finishB)d"
			} else {
				footerALabel.text = "\((row - 1) * 3)d" // start B, B wins
				footerBLabel.text = "\((row - 1) * 3 + finishB)d"
			}
		}
	}
	func setFinish(winner: String) {
		print("setFinish(winner: String)")
		if winner == "A" { // A wins
			footerFinishALabel.text = "X\(1)"
			footerALabel.text = "\((row) * 3 + 1)d"  // start A, A wins
			footerBLabel.text = "\((row) * 3)d"
		} else {
			footerFinishBLabel.text = "X\(1)"
			footerALabel.text = "\((row) * 3)d"  // start A, A wins
			footerBLabel.text = "\((row) * 3 + 1)d"
		}
	}
	
}
