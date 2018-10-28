//
//  SettingsViewController.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/09.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

class SettingsViewController: MotherViewController, UITextFieldDelegate {
	var selectedButton = 1
	// **************************************

//	@IBOutlet weak var startScore: UITextField!
//	@IBOutlet weak var numberOfTurns: UITextField!
	
	@IBOutlet weak var startingScoreButton: UIButton!
	@IBOutlet weak var numberOfTurnsButton: UIButton!
	@IBOutlet weak var numberOfSetsButton: UIButton!
	@IBOutlet weak var numberOfPlayersButton: UIButton!
	@IBOutlet weak var setLanguageButton: UIButton!
	@IBOutlet weak var cancelLabel: UIButton!
	
	@IBOutlet weak var playerA1: UIButton!
	@IBOutlet weak var playerA2: UIButton!
	@IBOutlet weak var playerA3: UIButton!
	@IBOutlet weak var playerA4: UIButton!
	@IBOutlet weak var playerA5: UIButton!
	@IBOutlet weak var playerA6: UIButton!
	
	@IBOutlet weak var playerB1: UIButton!
	@IBOutlet weak var playerB2: UIButton!
	@IBOutlet weak var playerB3: UIButton!
	@IBOutlet weak var playerB4: UIButton!
	@IBOutlet weak var playerB5: UIButton!
	@IBOutlet weak var playerB6: UIButton!
	
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: OVERRIDES
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		playerA1.backgroundColor = UIColor.cyan
//		searchBar.delegate = self
    }
	override func viewWillAppear(_ animated: Bool) {
		setPlayers(playersA: playersA, playersB: playersB)
		setButtonsLabels()
		self.view.setNeedsDisplay()
		self.view.setNeedsLayout()
//		currentNameArray = allPlayers
		fetchAllPlayers()
		tableView.reloadData()
	}
	
	
	
	
	// MARK: FUNCTIONS
	func setButtonsLabels() {
		// Get UserDefaultsLabels:
		let starting = defaults.string(forKey: "startingLabel") ?? "Starting: "
		let points = defaults.string(forKey: "pointsLabel") ?? " Points"
		let turnsLabel = defaults.string(forKey: "turnsLabel") ?? " Turns"
		let players = defaults.string(forKey: "playersLabel") ?? " Players"
		
		let lang = defaults.string(forKey: "languageLabel") ?? "Language"
		let setsLabel = defaults.string(forKey: "setsLabel") ?? " Legs"
//		let cancel = defaults.string(forKey: "cancelLabel") ?? "Cancel"
		
		startingScoreButton.setTitle( "\(starting)\(String(startingToGo))\(points)", for: .normal)
		numberOfTurnsButton.setTitle( "\(String(turnsNumber))\(turnsLabel)", for: .normal)
		numberOfSetsButton.setTitle("\(setsNumber) \(setsLabel)", for: .normal)
		numberOfPlayersButton.setTitle("\(String(playersNumber))\(players)", for: .normal)
		setLanguageButton.setTitle(lang, for: .normal)
//		cancelLabel.setTitle(cancel, for: .normal)
		
	}
	func setPlayers(playersA: [String], playersB: [String]) {
		setHiddenPlayers(numPlayers: playersNumber)
		var i = 0
		let count = playersA.count
		playerA1.setTitle(playersA[i], for: .normal); i += 1
		if i < count { playerA2.setTitle(playersA[i], for: .normal); i += 1 }
		if i < count { playerA3.setTitle(playersA[i], for: .normal); i += 1 }
		if i < count { playerA4.setTitle(playersA[i], for: .normal); i += 1 }
		if i < count { playerA5.setTitle(playersA[i], for: .normal); i += 1 }
		if i < count { playerA6.setTitle(playersA[i], for: .normal); i += 1 }
		
		i = 0
		playerB1.setTitle(playersB[i], for: .normal); i += 1
		if i < count { playerB2.setTitle(playersB[i], for: .normal); i += 1 }
		if i < count { playerB3.setTitle(playersB[i], for: .normal); i += 1 }
		if i < count { playerB4.setTitle(playersB[i], for: .normal); i += 1 }
		if i < count { playerB5.setTitle(playersB[i], for: .normal); i += 1 }
		if i < count { playerB6.setTitle(playersB[i], for: .normal); i += 1 }
	}
//	@IBAction func setPlayer(_ sender: Any) {
//		insertNewPlayer()
//	}
//	func insertNewPlayer() {
//		let playerName = searchBar.text!
//		players.append(playerName)
//		allPlayers.append(playerName)
//		//			currentNameArray = allPlayers
//		setPlayerToButton(playerName: playerName)
//		selectNextPlayer()
//		searchBar.text = ""
//
//		tableView.updateFocusIfNeeded()
//		searchBar.updateFocusIfNeeded()
//		tableView.reloadData()
//	}

	func clearSelectedButtons() {
		playerA1.backgroundColor = UIColor.clear
		playerA2.backgroundColor = UIColor.clear
		playerA3.backgroundColor = UIColor.clear
		playerA4.backgroundColor = UIColor.clear
		playerA5.backgroundColor = UIColor.clear
		playerA6.backgroundColor = UIColor.clear
		playerB1.backgroundColor = UIColor.clear
		playerB2.backgroundColor = UIColor.clear
		playerB3.backgroundColor = UIColor.clear
		playerB4.backgroundColor = UIColor.clear
		playerB5.backgroundColor = UIColor.clear
		playerB6.backgroundColor = UIColor.clear
	}
	func highlightButton(selectedButton: Int) {
		switch selectedButton {
		case 1:
			playerA1.backgroundColor = UIColor.cyan
		case 2:
			playerA2.backgroundColor = UIColor.cyan
		case 3:
			playerA3.backgroundColor = UIColor.cyan
		case 4:
			playerA4.backgroundColor = UIColor.cyan
		case 5:
			playerA5.backgroundColor = UIColor.cyan
		case 6:
			playerA6.backgroundColor = UIColor.cyan
		case 7:
			playerB1.backgroundColor = UIColor.cyan
		case 8:
			playerB2.backgroundColor = UIColor.cyan
		case 9:
			playerB3.backgroundColor = UIColor.cyan
		case 10:
			playerB4.backgroundColor = UIColor.cyan
		case 11:
			playerB5.backgroundColor = UIColor.cyan
		case 12:
			playerB6.backgroundColor = UIColor.cyan
		default:
			break
		}
	}
	func selectNextPlayer() {
		var jumper = 0
		var backer = 13
		switch playersNumber {
		case 2:
			jumper = 2
			backer = 8
		case 4:
			jumper = 3
			backer = 9
		case 6:
			jumper = 4
			backer = 10
		case 8:
			jumper = 5
			backer = 11
		case 10:
			jumper = 6
			backer = 12
		case 12:
			jumper = 7
			backer = 13
		default:
			break
		}
		clearSelectedButtons()
		if selectedButton < 12 {
			selectedButton += 1
		} else {
			selectedButton = 1
		}
		if selectedButton == jumper { selectedButton = 7 }
		if selectedButton == backer { selectedButton = 1 }
//		print("SelectedButton is \(selectedButton)")
		highlightButton(selectedButton: selectedButton)
	}
	func setPlayerToButton(playerName: String) {
		switch selectedButton {
		case 1:
			playerA1.setTitle(playerName, for: .normal)
		case 2:
			playerA2.setTitle(playerName, for: .normal)
		case 3:
			playerA3.setTitle(playerName, for: .normal)
		case 4:
			playerA4.setTitle(playerName, for: .normal)
		case 5:
			playerA5.setTitle(playerName, for: .normal)
		case 6:
			playerA6.setTitle(playerName, for: .normal)
		case 7:
			playerB1.setTitle(playerName, for: .normal)
		case 8:
			playerB2.setTitle(playerName, for: .normal)
		case 9:
			playerB3.setTitle(playerName, for: .normal)
		case 10:
			playerB4.setTitle(playerName, for: .normal)
		case 11:
			playerB5.setTitle(playerName, for: .normal)
		case 12:
			playerB6.setTitle(playerName, for: .normal)
		default:
			break
		}
	}
	func setStartingToGo() { //151,251,301,501,701,1001
		let toGoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		toGoAlert.addAction(UIAlertAction(title: "151", style: .default, handler: { (action: UIAlertAction!) in
			setStaTogo(num: 151)
		}))
		toGoAlert.addAction(UIAlertAction(title: "251", style: .default, handler: { (action: UIAlertAction!) in
			setStaTogo(num: 251)
		}))
		toGoAlert.addAction(UIAlertAction(title: "301", style: .default, handler: { (action: UIAlertAction!) in
			setStaTogo(num: 301)
		}))
		toGoAlert.addAction(UIAlertAction(title: "501", style: .default, handler: { (action: UIAlertAction!) in
			setStaTogo(num: 501)
		}))
		toGoAlert.addAction(UIAlertAction(title: "701", style: .default, handler: { (action: UIAlertAction!) in
			setStaTogo(num: 701)
		}))
		toGoAlert.addAction(UIAlertAction(title: "1001", style: .default, handler: { (action: UIAlertAction!) in
			setStaTogo(num: 1001)
		}))
		toGoAlert.popoverPresentationController?.sourceView = self.view
		toGoAlert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX / 2.2, y: self.view.bounds.midY / 2.6, width: 0, height: 0)
		toGoAlert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		present(toGoAlert, animated: true, completion: nil)
		func setStaTogo(num: Int) {
			startingToGo = num
			startingScoreButton.setTitle("\(num) To Go", for: .normal)
		}
		
	}
	func setNumberOfPlayers() {
		var numPlayers = 6
		let setNumPlayers = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		setNumPlayers.addAction(UIAlertAction(title: "Two Players", style: .default, handler: { (action: UIAlertAction!) in
			self.setHiddenPlayers(numPlayers: 2)
		}))
		setNumPlayers.addAction(UIAlertAction(title: "Four Players", style: .default, handler: { (action: UIAlertAction!) in
			self.setHiddenPlayers(numPlayers: 4)
		}))
		setNumPlayers.addAction(UIAlertAction(title: "Six Players", style: .default, handler: { (action: UIAlertAction!) in
			self.setHiddenPlayers(numPlayers: 6)
		}))
		setNumPlayers.addAction(UIAlertAction(title: "Eight Players", style: .default, handler: { (action: UIAlertAction!) in
			self.setHiddenPlayers(numPlayers: 8)
		}))
		setNumPlayers.addAction(UIAlertAction(title: "Ten Players", style: .default, handler: { (action: UIAlertAction!) in
			self.setHiddenPlayers(numPlayers: 10)
		}))
		setNumPlayers.addAction(UIAlertAction(title: "Twelve Players", style: .default, handler: { (action: UIAlertAction!) in
			self.setHiddenPlayers(numPlayers: 12)
		}))
		setNumPlayers.popoverPresentationController?.sourceView = self.view
		setNumPlayers.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY / 2, width: 0, height: 0) // GOOD POSITION
		setNumPlayers.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		present(setNumPlayers, animated: true, completion: nil)
		
		func setNumbPlayers(num: Int) {
			numPlayers = num
//			print("numPlayers: \(num)")
		}
		
		
	}
	func resetGame() {
		scoresA = Array(repeating: nil, count: turnsNumber)
		scoresB = Array(repeating: nil, count: turnsNumber)
		toGoesA = Array(repeating: nil, count: turnsNumber + 1)
		toGoesB = Array(repeating: nil, count: turnsNumber + 1)
		stateA = Array(repeating: 0, count: turnsNumber)
		stateB = Array(repeating: 0, count: turnsNumber)
		row = 0
		teamTurn = 0
	}
	func setLanguage() {
		let setLanguageView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		setLanguageView.addAction(UIAlertAction(title: "English", style: .default, handler: { (action: UIAlertAction!) in
			Language.labelsLanguage = "English"
			self.setButtonsLabels()
		}))
		setLanguageView.addAction(UIAlertAction(title: "Japanese", style: .default, handler: { (action: UIAlertAction!) in
			Language.labelsLanguage = "Japanese"
			self.setButtonsLabels()
		}))
		setLanguageView.addAction(UIAlertAction(title: "Portuguese", style: .default, handler: { (action: UIAlertAction!) in
			Language.labelsLanguage = "Portuguese"
			self.setButtonsLabels()
		}))
		setLanguageView.popoverPresentationController?.sourceView = self.view
		setLanguageView.popoverPresentationController?.sourceRect = CGRect(x: (self.view.bounds.midX / 3) * 4, y: self.view.bounds.midY / 3, width: 0, height: 0) // GOOD POSITION
		setLanguageView.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		present(setLanguageView, animated: true, completion: nil)
		
	}
	func setHiddenPlayers(numPlayers: Int) {
		
		playersNumber = numPlayers
		
		self.playerA2.isHidden = true; self.playerB2.isHidden = true
		self.playerA3.isHidden = true; self.playerB3.isHidden = true
		self.playerA4.isHidden = true; self.playerB4.isHidden = true
		self.playerA5.isHidden = true; self.playerB5.isHidden = true
		self.playerA6.isHidden = true; self.playerB6.isHidden = true
		
		if numPlayers >= 4 {
			self.playerA2.isHidden = false; self.playerB2.isHidden = false
		}
		if numPlayers >= 6 {
			self.playerA3.isHidden = false; self.playerB3.isHidden = false
		}
		if numPlayers >= 8 {
			self.playerA4.isHidden = false; self.playerB4.isHidden = false
		}
		if numPlayers >= 10 {
			self.playerA5.isHidden = false; self.playerB5.isHidden = false
		}
		if numPlayers >= 12 {
			self.playerA6.isHidden = false; self.playerB6.isHidden = false
		}
		selectedButton = 1
		clearSelectedButtons()
		playerA1.backgroundColor = UIColor.cyan
		numberOfPlayersButton.setTitle("\(String(numPlayers)) Players", for: .normal)

		self.view.setNeedsLayout()
		self.view.setNeedsDisplay()
	}
	
	func setNumberOfTurns() { // 10,12,15,40? //9,10,12,15,20 ?
		let setNumberOfTurns = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		setNumberOfTurns.addAction(UIAlertAction(title: "10", style: .default, handler: { (action: UIAlertAction!) in
			self.setNumbTurns(num: 10)
		}))
		setNumberOfTurns.addAction(UIAlertAction(title: "12", style: .default, handler: { (action: UIAlertAction!) in
			self.setNumbTurns(num: 12)
		}))
		setNumberOfTurns.addAction(UIAlertAction(title: "15", style: .default, handler: { (action: UIAlertAction!) in
			self.setNumbTurns(num: 15)
		}))
		setNumberOfTurns.addAction(UIAlertAction(title: "40", style: .default, handler: { (action: UIAlertAction!) in
			self.setNumbTurns(num: 40)
		}))
		setNumberOfTurns.popoverPresentationController?.sourceView = self.view
		setNumberOfTurns.popoverPresentationController?.sourceRect = CGRect(x: (self.view.bounds.midX / 3) * 2, y:  self.view.bounds.midY / 1.8, width: 0, height: 0) // GOOD POSITION
		setNumberOfTurns.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		present(setNumberOfTurns, animated: true, completion: nil)
	}
	func setNumbTurns(num: Int) {
		turnsNumber = num
		numberOfTurnsButton.setTitle("\(num) Turns", for: .normal)
	}
	func setNumberOfSets() { //1, 3 , 5, 7, 9, 11, 13 legs
		let numSets = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		numSets.addAction(UIAlertAction(title: "1", style: .default, handler: { (action: UIAlertAction!) in
			setNumSets(num: 1)
		}))
		numSets.addAction(UIAlertAction(title: "3", style: .default, handler: { (action: UIAlertAction!) in
			setNumSets(num: 3)
		}))
		numSets.addAction(UIAlertAction(title: "5", style: .default, handler: { (action: UIAlertAction!) in
			setNumSets(num: 5)
		}))
		numSets.addAction(UIAlertAction(title: "7", style: .default, handler: { (action: UIAlertAction!) in
			setNumSets(num: 7)
		}))
		numSets.addAction(UIAlertAction(title: "9", style: .default, handler: { (action: UIAlertAction!) in
			setNumSets(num: 9)
		}))
		numSets.addAction(UIAlertAction(title: "11", style: .default, handler: { (action: UIAlertAction!) in
			setNumSets(num: 11)
		}))
		numSets.addAction(UIAlertAction(title: "13", style: .default, handler: { (action: UIAlertAction!) in
			setNumSets(num: 13)
		}))
		numSets.popoverPresentationController?.sourceView = self.view
		numSets.popoverPresentationController?.sourceRect = CGRect(x: (self.view.bounds.midX / 3) * 2, y:  self.view.bounds.midY / 1.8, width: 0, height: 0) // GOOD POSITION
		numSets.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		present(numSets, animated: true, completion: nil)
		func setNumSets(num: Int) {
			setsNumber = num
			numberOfSetsButton.setTitle("\(num) Legs", for: .normal)
		}
	}
	
	@IBAction func addPlayer(_ sender: UIBarButtonItem) {
		
		let alert = UIAlertController(title: "New Player",
									  message: nil,
									  preferredStyle: .alert)
		
		let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
			trySavePlayer()
		}
		func trySavePlayer() {
			guard let textField = alert.textFields?.first,
				let nameToSave = textField.text else {
					return
			}
			if nameToSave == "" { return }
			for players in self.allPlayersData {
//				print("Here1!") // Passed
				if players.value(forKey: "name") as? String == nameToSave {
					print("Same Name: \(nameToSave)")
					return
				} else {
//					print("Not the Same: \(nameToSave)") // Passed!
				}
				
			}
			savePlayer(name: nameToSave)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel",
										 style: .cancel)
		alert.addTextField()
		
		alert.addAction(saveAction)
		alert.addAction(cancelAction)
		present(alert, animated: true)
		func savePlayer(name: String) {
			self.saveNewPlayer(name: name)
			self.fetchAllPlayers()
			self.tableView.reloadData()
			self.view.setNeedsDisplay()
		}
	}
	@IBAction func setNumberOfSets(_ sender: UIButton) {
		setNumberOfSets()
	}
	
	@IBAction func dismissSettingsView(_ sender: Any) {
		var newPlayersA = [String]()
		var newPlayersB = [String]()
		newPlayersA.append(playerA1.titleLabel?.text ?? "Player 1")
		if !playerA2.isHidden { newPlayersA.append(playerA2.titleLabel?.text ?? "Player 2") }
		if !playerA3.isHidden { newPlayersA.append(playerA3.titleLabel?.text ?? "Player 3") }
		if !playerA4.isHidden { newPlayersA.append(playerA4.titleLabel?.text ?? "Player 4") }
		if !playerA5.isHidden { newPlayersA.append(playerA5.titleLabel?.text ?? "Player 5") }
		if !playerA6.isHidden { newPlayersA.append(playerA6.titleLabel?.text ?? "Player 6") }
		newPlayersB.append(playerB1.titleLabel?.text ?? "Player 2")
		if !playerB2.isHidden { newPlayersB.append(playerB2.titleLabel?.text ?? "Player 2") }
		if !playerB3.isHidden { newPlayersB.append(playerB3.titleLabel?.text ?? "Player 3") }
		if !playerB4.isHidden { newPlayersB.append(playerB4.titleLabel?.text ?? "Player 4") }
		if !playerB5.isHidden { newPlayersB.append(playerB5.titleLabel?.text ?? "Player 5") }
		if !playerB6.isHidden { newPlayersB.append(playerB6.titleLabel?.text ?? "Player 6") }
		
		playersA = newPlayersA
		playersB = newPlayersB
		resetGame()
		tableView.reloadData()
		self.navigationController?.popViewController(animated: true)
//		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func setStartingToGo(_ sender: UIButton) {
		setStartingToGo()
	}
	@IBAction func setNumberOfTurnsAction(_ sender: UIButton) {
		setNumberOfTurns()
	}
	@IBAction func setNumberOfPlayersAction(_ sender: UIButton) {
		setNumberOfPlayers()
	}
	@IBAction func setLanguage(_ sender: Any) {
		setLanguage()
	}
	@IBAction func cancelSettings(_ sender: Any) {
		
	}
	@IBAction func SetName(_ sender: Any) {
		
	}
	@IBAction func selectPlayer(_ sender: UIButton) {
		clearSelectedButtons()
		
		sender.backgroundColor = UIColor.cyan
		
		switch sender {
		case playerA1:
			selectedButton = 1
		case playerA2:
			selectedButton = 2
		case playerA3:
			selectedButton = 3
		case playerA4:
			selectedButton = 4
		case playerA5:
			selectedButton = 5
		case playerA6:
			selectedButton = 6
		case playerB1:
			selectedButton = 7
		case playerB2:
			selectedButton = 8
		case playerB3:
			selectedButton = 9
		case playerB4:
			selectedButton = 10
		case playerB5:
			selectedButton = 11
		case playerB6:
			selectedButton = 12
		default:
			break
		}
		
	}

}
extension UserDefaults {
	func contains(key: String) -> Bool {
		return UserDefaults.standard.object(forKey: key) != nil
	}
}
