//
//  ScoreViewController.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/08.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit
import CoreData

class ScoreViewController: MotherViewController {
	// MARK: OUTLETS
	// Constraints:
	@IBOutlet weak var tableViewBottomConstraints: NSLayoutConstraint!
	@IBOutlet weak var keyboardTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var keyboardHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var keyboardBottomConstraint: NSLayoutConstraint!
	
//	@IBOutlet weak var keyboardHeight: NSLayoutConstraint!
//	@IBOutlet weak var keyboardBottom: NSLayoutConstraint!
	
	
	
//	@IBOutlet weak var winnerLabelBottom: NSLayoutConstraint!
	// Hidden View Controller:
	@IBOutlet weak var hiddenView: UIView!
	@IBOutlet weak var keyboardView: KeyboardView!
	
//	@IBOutlet weak var winnerLabel: UILabel!
	@IBOutlet weak var nextGameButton: BiggestButton!
	@IBOutlet weak var showKeyboardView: UIView!
	
	@IBOutlet weak var rightNavigatorButton: UIBarButtonItem!
	
	
	// Above Header
	@IBOutlet weak var labelAName: BoardLabel! // Don't need
	@IBOutlet weak var labelAScore: BoardLabel! // Check
	@IBOutlet weak var labelBScore: BoardLabel! // Check
	@IBOutlet weak var labelAToGo: UILabel! // Check
	@IBOutlet weak var labelBToGo: UILabel! // Check
	@IBOutlet weak var labelBName: BoardLabel! // Don't need
	
	
	@IBOutlet weak var headerAName: BoardLabel!
	@IBOutlet weak var headerAScore: BoardLabel!
	@IBOutlet weak var headerAToGo: BoardLabel! // Check
	@IBOutlet weak var headerCenter: BoardLabel!
	@IBOutlet weak var headerBScore: BoardLabel!
	@IBOutlet weak var headerBToGo: BoardLabel! // Check
	@IBOutlet weak var headerBName: BoardLabel!
	
	
	// Table View:
	@IBOutlet weak var tableView: UITableView!
	
	
	// Numbers Pad:
	@IBOutlet weak var key1: NumberButton!
	@IBOutlet weak var key2: NumberButton!
	@IBOutlet weak var key3: NumberButton!
	@IBOutlet weak var key4: NumberButton!
	@IBOutlet weak var key5: NumberButton!
	@IBOutlet weak var key6: NumberButton!
	@IBOutlet weak var key7: NumberButton!
	@IBOutlet weak var key8: NumberButton!
	@IBOutlet weak var key9: NumberButton!
	@IBOutlet weak var key0: NumberButton!
	
	// Burst and Finish:
	@IBOutlet weak var burstButton: BigButton!
	@IBOutlet weak var finishButton: BigButton!
	
	@IBOutlet weak var hideKeyboardButton: BigButton!
	
	// MARK:
	// MARK: VARIABLES
	// MARK:
	var finish = 0
	var keyboardHeightSetter: CGFloat = 300
	// MARK: CORE DATA:
	var playersToSaveA = [PlayerToSave]()
	var playersToSaveB = [PlayerToSave]()
	var legsTurnsToSave = 0
	var nameToSave: String = ""
	var scoresToSave = [Int]()
	var winsToSave = 0
	var legsToSave: Int = 0
	func setPlayersToSave() {
		playersToSaveA = []
		playersToSaveB = []
		for player in playersA {
			let newPlayerToSave = PlayerToSave(name: player)
			playersToSaveA.append(newPlayerToSave)
		}
		for player in playersB {
			let newPlayerToSave = PlayerToSave(name: player)
			playersToSaveB.append(newPlayerToSave)
		}
	}
	func updatePlayersToSaveWins() {
		for players in playersToSaveA {
			players.games += 1
			if gameWinner == "A" {
				players.wins += 1
			}
		}
		for players in playersToSaveB {
			players.games += 1
			if gameWinner == "B" {
				players.wins += 1
			}
		}
	}
	
	func updatePlayerToSaveScore() {
		for (ind, player) in playersToSaveA.enumerated() {
			// Add Leg:
			player.legs += 1
			// Add Scores:
			for index in 0...(row) {
				if sets[index].playerA == player.name {
					if let score = Int(sets[index].scoreA) {
						playersToSaveA[ind].scores.append(score)
						player.turns += 3
					} else if index > 0 {
						if let restScore = Int(sets[index - 1].toGoA) {
							if legWinner == "A" {
								playersToSaveA[ind].scores.append(restScore)
								playersToSaveA[ind].turns += finish
								//								print("RestScore saved.")
							}
						}
					}
				}
			}
		}
		for (ind, player) in playersToSaveB.enumerated() {
			// Add Leg:
			player.legs += 1
			// Add Scores:
			for index in 0...(row) {
				if sets[index].playerB == player.name {
					if let score = Int(sets[index].scoreB) {
						playersToSaveB[ind].scores.append(score)
						player.turns += 3
					} else if index > 0 {
						if let restScore = Int(sets[index - 1].toGoB) {
							if legWinner == "B" {
								playersToSaveB[ind].scores.append(restScore)
								playersToSaveB[ind].turns += finish
								//								print("RestScore saved.")
							}
						}
					}
				}
			}
		}
	}
	//	var isDouble = false
	// MARK: VARIABLES
	var leg = 1
	var gameStarted = false {
		didSet {
			if gameStarted {
				rightNavigatorButton.title = "Abort"
				//				tableViewFooter.isHidden = true
			}
			
		}
	}
	var gameWinner: String? = nil {
		didSet {
			switch gameWinner {
			case "A","B":
				updatePlayersToSaveWins()
//				winnerLabel.text = "\(gameWinner!) Team Wins!"
//				winnerLabel.isHidden = false
//				winnerLabelBottom.constant = 180
				self.view.layoutIfNeeded()
				animateWinLabel()
				rightNavigatorButton.title = "Settings"
				nextGameButton.setTitle("New Game", for: .normal)
				
				updatePlayers()
				print("********** Team A ******************************")
				for player in playersToSaveA {
					print("Player: \(player.name), scores: \(player.scores)")
					print("\(player.legs) legs, \(player.turns) turns, \(player.wins) wins")
					print("****************************************")
				}
				print("********** Team B ******************************")
				for player in playersToSaveB {
					print("Team B: \(player.name), scores: \(player.scores)")
					print("\(player.legs) legs, \(player.turns) turns, \(player.wins) wins")
					print("****************************************")
				}
				print("****************************************")
				print("****************************************")
				print("****************************************")
			case nil:
				nextGameButton.setTitle("Next Leg", for: .normal)
				hiddenView.isHidden = true
			default:
				break
			}
		}
	}
	func updatePlayers() {
		fetchAllPlayers()
		for playerData in allPlayersData {
			let name = playerData.value(forKey: "name") as? String
			for player in playersToSaveA {
				if name == player.name {
					// Games:
					var gamesData = playerData.value(forKey: "games") as? Int
					gamesData = gamesData! + player.games
					playerData.setValue(gamesData, forKey: "games")
					// Wins:
					var winsData = playerData.value(forKey: "wins") as? Int
					winsData = winsData! + player.wins
					playerData.setValue(winsData, forKey: "wins")
					// Legs:
					var legsData = playerData.value(forKey: "legs") as? Int
					legsData = legsData! + player.legs
					playerData.setValue(legsData, forKey: "legs")
					// Turns:
					var turnsData = playerData.value(forKey: "turns") as? Int
					turnsData = turnsData! + player.turns
					playerData.setValue(turnsData, forKey: "turns")
					// Scores:
					var scoresData = playerData.value(forKey: "scores") as? [Int] ?? []
					scoresData = scoresData + player.scores
					playerData.setValue(scoresData, forKey: "scores")
					// Average:
					var sum: Float = 0
					let scores = scoresData
					var average: Float = 0.0
					for score in scores {
						sum += Float(score)
					}
					if turnsData != 0 && turnsData != nil {
						average = sum / Float(turnsData!)
					}
					playerData.setValue(average, forKey: "average")
					// Match Average:
					var matchScoresSum: Float = 0
					let matchTurns: Float = Float(player.scores.count)
					for score in player.scores {
						matchScoresSum = matchScoresSum + Float(score)
					}
					let matchAverage: [Float] = [(matchScoresSum / matchTurns).rounded(toPlaces: 4)]
					var matchScoresData: [Float] = []
					if (playerData.value(forKey: "matchAverages") as? [Float]) == nil {
						print("Is nil")
					} else {
						matchScoresData = (playerData.value(forKey: "matchAverages") as? [Float])!
					}
					let newMatchData = matchScoresData + matchAverage
					playerData.setValue(newMatchData, forKey: "matchAverages")
					print("\(player.name) average is \(matchAverage)")
					guard let testAverage = playerData.value(forKey: "matchAverages") as? [Float] else { print("test average fail."); return }
					for average in testAverage {
						print("test average: \(average)")
					}
				}
			}
		}
		for playerData in allPlayersData {
			let name = playerData.value(forKey: "name") as? String
			for player in playersToSaveB {
				if name == player.name {
					// Games:
					var gamesData = playerData.value(forKey: "games") as? Int
					gamesData = gamesData! + player.games
					playerData.setValue(gamesData, forKey: "games")
					// Wins:
					var winsData = playerData.value(forKey: "wins") as? Int
					winsData = winsData! + player.wins
					playerData.setValue(winsData, forKey: "wins")
					// Legs:
					var legsData = playerData.value(forKey: "legs") as? Int
					legsData = legsData! + player.legs
					playerData.setValue(legsData, forKey: "legs")
					// Turns:
					var turnsData = playerData.value(forKey: "turns") as? Int
					turnsData = turnsData! + player.turns
					playerData.setValue(turnsData, forKey: "turns")
					// Scores:
					var scoresData = playerData.value(forKey: "scores") as? [Int] ?? []
					scoresData = scoresData + player.scores
					playerData.setValue(scoresData, forKey: "scores")
					// Average:
					var sum: Float = 0
					let scores = scoresData
					var average: Float = 0.0
					for score in scores {
						sum += Float(score)
					}
					if turnsData != 0 && turnsData != nil {
						average = sum / Float(turnsData!)
					}
					playerData.setValue(average, forKey: "average")
					// Match Average:
					var matchScoresSum: Float = 0
					let matchTurns: Float = Float(player.scores.count)
					for score in player.scores {
						matchScoresSum = matchScoresSum + Float(score)
					}
					let matchAverage: [Float] = [matchScoresSum / matchTurns]
					var matchScoresData: [Float] = []
					if (playerData.value(forKey: "matchAverages") as? [Float]) == nil {
						print("Is nil")
					} else {
						matchScoresData = (playerData.value(forKey: "matchAverages") as? [Float])!
					}
					let newMatchData = matchScoresData + matchAverage
					playerData.setValue(newMatchData, forKey: "matchAverages")
					print("\(player.name) average is \(matchAverage)")
					guard let testAverage = playerData.value(forKey: "matchAverages") as? [Float] else { print("test average fail."); return }
					for average in testAverage {
						print("test average: \(average)")
					}
				}
			}
		}
	}
	var legWinner: String? = nil
	func animateWinLabel() {
//		winnerLabelBottom.constant = self.view.bounds.maxY
//
//		UIView.animate(withDuration: 5.0, animations: {
//			self.view.layoutIfNeeded()
//		})
	}
	var legsA = 0 {
		didSet {
			if legsA >= 0 {
				legWinner = "A"
			}
			checkLegs()
		}
	}
	var legsB = 0 {
		didSet {
			if legsB >= 0 {
				legWinner = "B"
			}
			checkLegs()
		}
	}
	func checkLegs() {
		if isGameOver { showHiddenView()
			hideKeyboard()
			updatePlayerToSaveScore()
		} else {
			hideHiddenView()
			showKeyboard()
		}
		title = "\(legsA) - \(legsB)"
		if legsA >= legsLimit {
			gameWinner = "A"
		} else if legsB >= legsLimit {
			gameWinner = "B"
		}
	}
	func showHiddenView() {
		hiddenView.isHidden = false
	}
	func hideHiddenView() {
		hiddenView.isHidden = true
	}
	func hideKeyboard() {
//		keyboardTopConstraint.constant = 0
//		tableViewBottomConstraints.constant = 0
//		keyboardHeightConstraint.constant = 0
//		keyboardBottomConstraint.constant = 250
		
		keyboardView.isHidden = true
		tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
		})
		
	}
	func showKeyboard() {
//		keyboardTopConstraint.constant = 300
//		tableViewBottomConstraints.constant = 250
//		keyboardHeightConstraint.constant = 250
//		keyboardBottomConstraint.constant = 0
		
		keyboardView.isHidden = false
		tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = false
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
		})
	}
	func showShowKeyboard() {
		showKeyboardView.isHidden = false
	}
	func hideShowKeyboard() {
		showKeyboardView.isHidden = true
	}
	enum team {
		case A
		case B
	}
	
	
	
	// #######################################
	// #######################################
	// #######################################
	var isNotGameOver = true
	var isGameOver = false {
		didSet {
			isNotGameOver = !isGameOver
			if isGameOver {
				key1.isEnabled = false
				key2.isEnabled = false
				key3.isEnabled = false
				key4.isEnabled = false
				key5.isEnabled = false
				key6.isEnabled = false
				key7.isEnabled = false
				key8.isEnabled = false
				key9.isEnabled = false
				key0.isEnabled = false
				burstButton.isEnabled = false
				finishButton.isEnabled = false
			} else {
				key1.isEnabled = true
				key2.isEnabled = true
				key3.isEnabled = true
				key4.isEnabled = true
				key5.isEnabled = true
				key6.isEnabled = true
				key7.isEnabled = true
				key8.isEnabled = true
				key9.isEnabled = true
				key0.isEnabled = true
				burstButton.isEnabled = true
				finishButton.isEnabled = true
				
				// Footer:
				//				tableViewFooter.isHidden = false
			}
		}
	}
	var numberOfDarts = "2"
	var sets: [Set] = []
	// MARK:
	// MARK: OVERRIDES
	// MARK:
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		switch rightNavigatorButton.title {
		case "Settings":
			return true
		case "Abort":
			askToResetGame()
			return false
		default:
			return false
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		keyboardHeightSetter = keyboardHeightConstraint.constant
		//		let insets = UIEdgeInsets(top: 0, left: 0, bottom: 400, right: 0)
		//		self.tableView.contentInset = insets
		self.view.setGradientBackground(colorOne: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), colorTwo: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1))
		self.tableView.separatorStyle = .none
		//		self.tableView.backgroundColor = UIColor.black
		tableView.delegate = self
		tableView.dataSource = self
		
//		self.fetchAllPlayers()
		
	}
	override func viewWillAppear(_ animated: Bool) {
		resetArrays()
		
		scoresA = Array(repeating: nil, count: turnsNumber)
		scoresB = Array(repeating: nil, count: turnsNumber)
		toGoesA = Array(repeating: nil, count: turnsNumber + 1)
		toGoesB = Array(repeating: nil, count: turnsNumber + 1)
		
		
//		createTestData()
		stateA = Array(repeating: 0, count: turnsNumber)
		stateB = Array(repeating: 0, count: turnsNumber)
		headerAToGo.text = String(startingToGo)
		headerBToGo.text = String(startingToGo)
		sets = updateTableView()
		tableView.reloadData()
		
		// Set labels language:
		
		// Set Navigation Controller Title:
		if setsNumber == 1 { title = "" }
		else { title = "0 - 0" }
		
		
		// Above Hearder
		labelAScore.text = defaults.string(forKey: "scoreLabel") ?? "Score"
		labelBScore.text = defaults.string(forKey: "scoreLabel") ?? "Score"
		labelAToGo.text = defaults.string(forKey: "toGoLabel") ?? "To Go"
		labelBToGo.text = defaults.string(forKey: "toGoLabel") ?? "To Go"
		if self.view.bounds.height > 700 {
			keyboardHeightSetter = 250
		}
		
		// Header
		headerAName.text = defaults.string(forKey: "nameLabel") ?? "Name "
		headerBName.text = defaults.string(forKey: "nameLabel") ?? "Name "
		
		
		
		//		let reset = UserDefaults.standard.string(forKey: "resetLabel") ?? "Reset"
		
		
		toGoesA[0] = Int(headerAToGo.text!) ?? 251
		toGoesB[0] = Int(headerBToGo.text!) ?? 251
		
		
		// Reset Game:
		resetGame()
		
		setPlayersToSave()
	}
	// MARK: FUNCTIONS
	// #######################################
	// #######################################
	func createTestData() {
		
		
		let names = ["John","Jonathan","Marco","Lucy","Michael","Matt","William","Sarah"]
		let averages1: [Float] = [40, 45, 44, 46.2, 50, 48, 51, 50, 60, 55, 58, 60, 58, 62, 55, 66.2, 70, 64, 72, 68, 74, 80, 73, 81]
		let averages2: [Float] = [44, 45, 42, 40.2, 58, 53, 56, 51, 63, 51, 53, 50, 54, 55, 52, 57.2, 55, 58, 57, 60, 61, 70, 69, 72]
		let averages3: [Float] = [10, 15, 14, 16.2, 15, 10, 20, 22, 25, 30, 31, 36, 44, 45, 42, 40.2, 58, 53, 56, 51, 63, 51, 53, 50]
		let averages4: [Float] = [110, 105, 112, 114.2, 128, 133, 126, 111, 113, 121, 133, 120, 124, 128, 127, 130.2, 132, 139, 135, 140, 144, 150, 147, 161]
		let averages5: [Float] = [40, 45, 44, 46.2, 50, 48, 51, 50, 60, 55, 58, 60, 53, 56, 51, 63, 51, 53, 50, 54, 55, 52, 57.2, 55]
		let averages6: [Float] = [44, 45, 42, 40.2, 58, 53, 56, 51, 63, 51, 53, 50, 51, 53, 50, 54, 55, 52, 57.2, 55, 58, 57, 60, 61]
		let averages7: [Float] = [10, 15, 14, 16.2, 15, 8, 21, 10, 20, 25, 18, 36, 14, 16.2, 15, 10, 20, 22, 25, 30, 31, 36, 44, 45]
		let averages8: [Float] = [111, 105, 112, 114.2, 128, 133, 126, 111, 113, 121, 133, 120, 114, 116.2, 115, 110, 120, 122, 125, 130, 131, 136, 144, 145]
		let allAverages = [averages1, averages2, averages3, averages4, averages5, averages6, averages7, averages8]
		let wins = [10,11,5,20,15,14,6,19]
		let games = Array(repeating: 24, count: 8)
		
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		
		for (index,name) in names.enumerated() {
			
			let context = appDelegate.persistentContainer.viewContext
			
			
			let entity = NSEntityDescription.entity(forEntityName: "Player", in: context)!
			let player = NSManagedObject(entity: entity, insertInto: context)
			player.setValue(name, forKey: "name")
			player.setValue(allAverages[index], forKey: "matchAverages")
			// get average:
			var sum: Float = 0
			for average in allAverages[index] {
				sum = sum + average
			}
			let finalAverage = (sum / Float(allAverages[index].count)).rounded(toPlaces: 2)
			player.setValue(finalAverage, forKey: "average")
			player.setValue(wins[index], forKey: "wins")
			player.setValue(games[index], forKey: "games")
			do {
				try context.save()
			} catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
			}
		}
		
		
		
		//		self.saveNewPlayer(name: name)
		//		self.fetchAllPlayers()
		//		self.view.setNeedsDisplay()
		//		self.tableView.reloadData()
		
		
	}
	// #######################################
	func updateToGoesA() {
		var restScore = startingToGo
		var tempScore = startingToGo
		for (index, scoreA) in scoresA.enumerated() {
			if scoreA != nil {
				tempScore -= scoreA!
				if tempScore > 1 {
					restScore = tempScore
					toGoesA[index + 1] = tempScore
				} else {
					// Burst
					tempScore = restScore
					toGoesA[index + 1] = restScore
					// stateA[index] = 2 // Burst
				}
			}
		}
	}
	func updateToGoesB() {
		var restScore = startingToGo
		var tempScore = startingToGo
		for (index, scoreB) in scoresB.enumerated() {
			if scoreB != nil {
				tempScore -= scoreB!
				if tempScore > 1 {
					restScore = tempScore
					toGoesB[index + 1] = tempScore
				} else {
					// Burst
					tempScore = restScore
					toGoesB[index + 1] = restScore
					// stateA[index] = 2 // Burst
				}
			}
		}
	}
	func setBurst() {
		inputHolder = "0"
		switch teamTurn {
		case 0:
			scoresA[row] = 0
			stateA[row] = 2
		case 1:
			scoresB[row] = 0
			stateB[row] = 2
		default:
			break
		}
		//		printScores()
		sets = updateTableView()
		tableView.reloadData()
		self.view.setNeedsDisplay()
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
			finish = number
			gameStarted = true
			isGameOver = true
			switch teamTurn {
			case 0:
				sets[row].toGoA = "X\(number)"
				scoresA[row] = toGoesA[row]
				legsA += 1
			case 1:
				sets[row].toGoB = "X\(number)"
				scoresB[row] = toGoesB[row]
				legsB += 1
			default:
				break
			}
			tableView.reloadData()
		}
	}
	func updateTableView() -> [Set] {
		var tempSets: [Set] = []
		
		// Insert turn labels:
		var turn = 3
		for i in 0..<scoresA.count {
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
			
			let set = Set.init(playerA: "", playerB: "", scoreA: scoreA, scoreB: scoreB, toGoA: toGoA, toGoB: toGoB, turnNumber: String(turn))
			tempSets.append(set)
			turn += 3
		}
		// Insert player Names:
		let indexA = playersA.count - 1
		var index = 0
		for i in 0..<scoresA.count {
			tempSets[i].playerA = playersA[index]
			tempSets[i].playerB = playersB[index]
			if index < indexA { index += 1 }
			else { index = 0 }
		}
		// Add One More Set(Center):
		let centerSet: Set = Set(playerA: "", playerB: "", scoreA: "", scoreB: "", toGoA: "", toGoB: "", turnNumber: "C")
		tempSets.append(centerSet)
		// Add last set(Darts throw count):
		var throwsCountSet: Set = Set(playerA: "", playerB: "", scoreA: "", scoreB: "", toGoA: "", toGoB: "", turnNumber: "D")
		if isGameOver {
			switch legWinner {
			case "A":
				throwsCountSet.toGoA = numberOfDarts
			case "B":
				throwsCountSet.scoreB = numberOfDarts
			default:
				break
			}
		}
		tempSets.append(throwsCountSet)
		
		return tempSets
	}
	
	
	
	//
	func insertScoreIntoArray() {
		switch teamTurn {
		case 0:
			scoresA[row] = Int(inputHolder) ?? nil
		case 1:
			scoresB[row] = Int(inputHolder) ?? nil
		default:
			break
		}
	}
	func resetPresentScore() {
		switch teamTurn {
		case 0:
			scoresA[row] = nil
		case 1:
			scoresB[row] = nil
		default:
			break
		}
	}
	func resetPresentTeamState() {
		switch teamTurn {
		case 0:
			stateA[row] = 0
		case 1:
			stateB[row] = 0
		default:
			break
		}
	}
	
	// 1 text Field Pointers
	func setNextScoreField() {
		// Last row case:
		func showCenterNearestDartsAlert() {
			let resetAlert = UIAlertController(title: "Select Winner", message: "Are You Sure?", preferredStyle: .alert)
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
				finish = 1
				numberOfDarts = String((row * 3) + 1)
				gameStarted = true
				isGameOver = true
				switch winner {
				case "A":
					legsA += 1
				case "B":
					legsB += 1
				default:
					print("nil?")
					break
				}
				sets = updateTableView()
				tableView.reloadData()
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
	func integerValueIsSmallerThanLimits(int: Int?) -> Bool  {
		var maxScore = 90
		if defaults.contains(key: "maxScore") {
			maxScore = defaults.integer(forKey: "maxScore")
		}
		if int == nil { return false }
		switch teamTurn {
		case 0:
			if int! > toGoesA[row] ?? maxScore  { return false }
		case 1:
			if int! > toGoesB[row] ?? maxScore { return false }
		default:
			break
			
		}
		if int! > maxScore { return false }
		
		return true
	}
	func insertNumberToCurrentScore(_ value: String){
		// Testing if not bursting:
		var testNumber = inputHolder
		testNumber.append(value)
		let intNumber = Int(testNumber)
		let valueAccepted = integerValueIsSmallerThanLimits(int: intNumber)
		if valueAccepted {
			inputHolder = testNumber
			insertScoreIntoArray()
			//			printScores()
			sets = updateTableView()
			
			tableView.reloadData()
			tableView.setNeedsDisplay()
		}
		
	}
	func printScores() {
		print("Score A", terminator: ": ")
		for score in scoresA {
			print(score ?? " ", terminator: ", ")
		}
		print(" ")
		print("Score B", terminator: ": ")
		for score in scoresB {
			print(score ?? " ", terminator: ", ")
		}
		print(" ")
	}
	func newLeg() {
		leg += 1
		resetArrays()
		row = 0
		if leg % 2 == 0 { teamTurn = 1 } else { teamTurn = 0 }
		sets = updateTableView()
		tableView.reloadData()
		isGameOver = false
		gameWinner = nil
		gameStarted = false
		hideHiddenView()
		showKeyboard()
		inputHolder = ""
	}
	func resetGame() {
		resetArrays()
		row = 0
		teamTurn = 0
		sets = updateTableView()
		tableView.reloadData()
		isGameOver = false
		legsA = 0
		legsB = 0
		gameWinner = nil
		gameStarted = false
		hideHiddenView()
//		winnerLabel.isHidden = true
		leg = 1
		inputHolder = ""
		rightNavigatorButton.title = "Settings"
	}
	func resetArrays() {
		scoresA = Array(repeating: nil, count: turnsNumber)
		scoresB = Array(repeating: nil, count: turnsNumber)
		toGoesA = Array(repeating: nil, count: turnsNumber + 1)
		toGoesB = Array(repeating: nil, count: turnsNumber + 1)
		stateA = Array(repeating: 0, count: turnsNumber)
		stateB = Array(repeating: 0, count: turnsNumber)
	}
	func oneStepBack() {
		
		if leg % 2 != 0 { // Odd legs case
			if teamTurn == 1 {
				scoresB[row] = nil
				toGoesB[row + 1] = nil
				toGoesA[row + 1] = nil
				scoresA[row] = nil
				teamTurn = 0
			} else if row != 0 {
				scoresA[row] = nil
				toGoesA[row + 1] = nil
				row -= 1
				teamTurn = 1
				scoresB[row] = nil
				toGoesB[row + 1] = nil
			}
		} else { // Even legs
			if teamTurn == 1 && row != 0  {
				scoresB[row] = nil
				toGoesB[row + 1] = nil
				teamTurn = 0
				row -= 1
				toGoesA[row + 1] = nil
				scoresA[row] = nil
			} else {
				scoresA[row] = nil
				toGoesA[row + 1] = nil
				teamTurn = 1
				scoresB[row] = nil
				toGoesB[row + 1] = nil
			}
		}
		inputHolder = ""
		sets = updateTableView()
		tableView.reloadData()
	}
	func askToResetGame() {
		let resetAlert = UIAlertController(title: "Abort Game", message: "Are You Sure?", preferredStyle: .alert)
		resetAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
			self.resetGame()
		}))
		resetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(resetAlert, animated: true, completion: nil)
	}
	// #######################################
	// #######################################
	// #######################################
	// #######################################
	// #######################################
	// MARK: ACTIONS
	@IBAction func numberKeyPressed(_ sender: NumberButton) {
		if isGameOver == false {
			switch teamTurn {
			case 0:
				//scoresA[row] = nil
				stateA[row] = 0
			case 1:
				//scoresB[row] = nil
				stateB[row] = 0
			default:
				break
			}
			insertNumberToCurrentScore((sender.titleLabel?.text)!)
		}
	}
	@IBAction func burst(_ sender: Any) {
		setBurst()
	}
	@IBAction func xDarts(_ sender: Any) {
		askDartsNumber()
	}
	@IBAction func backspacePressed(_ sender: Any) {
		if isGameOver == false {
			if inputHolder.count > 0 { inputHolder = String(inputHolder.dropLast()) }
			insertScoreIntoArray()
			sets = updateTableView()
			tableView.reloadData()
		}
	}
	@IBAction func clearKeyPressed(_ sender: Any) {
		if isGameOver == false {
			inputHolder = ""
			resetPresentScore()
			resetPresentTeamState()
			sets = updateTableView()
			tableView.reloadData()
		}
	}
	@IBAction func enterKeyPressed(_ sender: Any) {
		if isNotGameOver {
			gameStarted = true
			if inputHolder != "" {
				if inputHolder == "B" {
					updateToGoesA()
					updateToGoesB()
					setNextScoreField()
					sets = updateTableView()
					tableView.reloadData()
				} else {
					updateToGoesA()
					updateToGoesB()
					setNextScoreField()
					sets = updateTableView()
					tableView.reloadData()
				}
			}
		}
	}
	@IBAction func oneStepback(_ sender: Any) {
		oneStepBack()
	}
	@IBAction func hideKeyboardAction(_ sender: Any) {
		hideKeyboard()
		showShowKeyboard()
	}
	@IBAction func showKeyboardAction(_ sender: Any) {
		showKeyboard()
		hideShowKeyboard()
	}
	@IBAction func nextGameAction(_ sender: UIButton) {
		switch sender.titleLabel?.text {
		case "Next Leg":
			newLeg()
		case "New Game":
			resetGame()
		default:
			break
		}
		
	}
	func printer() {
		// This is the View I want to print
		let testView = self.view
		
		let printInfo = UIPrintInfo(dictionary:nil)
		printInfo.outputType = UIPrintInfo.OutputType.general
		printInfo.jobName = "My Print Job"
		
		// Set up print controller
		let printController = UIPrintInteractionController.shared
		printController.printInfo = printInfo
		
		// Assign a UIImage version of my UIView as a printing iten
		printController.printingItem = testView!.toImage()
		
		// Do it
		printController.present(animated: true) { (UIPrintInteractionController, true, error) in
			self.showKeyboard()
		}
	}
	@IBAction func printWithPrinter(_ sender: Any) {
		hideKeyboard()
		printer()
	}
}

extension UIView {
	func toImage() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
		
		drawHierarchy(in: self.bounds, afterScreenUpdates: true)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image!
	}
}

extension Float {
	/// Rounds the double to decimal places value
	func rounded(toPlaces places: Int) -> Float {
		let divisor = pow(10.0, Float(places))
		return (self * divisor).rounded() / divisor
	}
}
