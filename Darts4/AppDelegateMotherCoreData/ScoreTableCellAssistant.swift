//
//  ScoreTableCellAssistant.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/14.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation

class PlayerToSave {
	var name: String
	var legs = 0
	var scores = [Int]()
	var wins = 0
	var turns = 0
	var games = 0
	
	init(name: String) {
		self.name = name
	}
}

class ScoreTableCellAssistant {
	static var teamTurn = 0
	static var row = 0
	static var numberOfTurns = 0
	
	
	// 1 text Field Pointers
	func setNextScoreField() {
		if ScoreTableCellAssistant.teamTurn == 0 {
			ScoreTableCellAssistant.teamTurn = 1
		} else {
			if ScoreTableCellAssistant.row < (ScoreTableCellAssistant.numberOfTurns - 1) { ScoreTableCellAssistant.row += 1 }
			else { ScoreTableCellAssistant.row = 0 }
			ScoreTableCellAssistant.teamTurn = 0
		}
//		inputHolder = ""
	}
}
