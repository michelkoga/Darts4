//
//  HistoryDisplayViewController.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/17.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit
import CoreData

class HistoryDisplayViewController: MotherViewController {
	
	// Header Labels
	@IBOutlet weak var nameHeaderLabel: GrayLabel!
	@IBOutlet weak var gamesHeaderLabel: GrayLabel!
	@IBOutlet weak var winsHeaderLabel: GrayLabel!
	@IBOutlet weak var averageHeaderLabel: GrayLabel!
	
	
	//	var allPlayersData: [NSManagedObject] = []
	let players = ["Michel", "Willie", "Mvario"]
	let games = ["Today","Last Week", "Last Month"]
	
	var selectedButtonTag: Int? = nil
	
	@IBOutlet weak var underGraphsView: UnderGraphsView!
	@IBOutlet weak var averageLabel: UILabel!
	var collectionToDisplay = [String]()
	
	@IBOutlet weak var switcher: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
	
	@IBOutlet weak var graphView: GraphsView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchAllPlayers()
		switch switcher.selectedSegmentIndex {
		case 0:
			collectionToDisplay = players
		case 1:
			collectionToDisplay = games
		default:
			break
		}
	}
	override func viewWillAppear(_ animated: Bool) {
		setLabelsTitles()
		tableView.reloadData()
	}
	func setLabelsTitles() {
		// Navigator:
		title = Language.stats
		// Header:
		nameHeaderLabel.text = Language.name
		gamesHeaderLabel.text = Language.numberOfGames
		winsHeaderLabel.text = Language.numberOfWins
		averageHeaderLabel.text = Language.average
	}
	func showPlayerStats(playerName: String) {
		print("I can pass information here.")
	}
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		
	}
	func showStats(index: Int) {
		graphView.playerIndex = index
		underGraphsView.playerIndex = index
		graphView.setNeedsDisplay()
		underGraphsView.setNeedsDisplay()
		
	}
	@IBAction func switchMode(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			collectionToDisplay = players
		case 1:
			collectionToDisplay = games
		default:
			break
		}
		tableView.reloadData()
	}
	//	@IBAction func back(_ sender: UIBarButtonItem) {
	//	}
	@IBAction func setIndexPath(_ sender: UIButton) {
		allPlayersDataSelectedRow = sender.tag
		print("setIndexPath, allPlayersSelectedRow is \(allPlayersDataSelectedRow)")
		let newViewController = StatsViewController()
		self.navigationController?.pushViewController(newViewController, animated: true)
	}
	
	@IBAction func showStats(_ sender: UIButton) {
		let myTag = sender.tag
		selectedButtonTag = myTag
		showStats(index: myTag)
		tableView.reloadData()
	}
}
extension HistoryDisplayViewController: UITabBarDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allPlayersData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryTableViewCell else {
			return UITableViewCell()
		}
		let name = allPlayersData[indexPath.row].value(forKey: "name") as? String
		let games = allPlayersData[indexPath.row].value(forKey: "games") as? Int
		let wins = allPlayersData[indexPath.row].value(forKey: "wins") as? Int
		let average = allPlayersData[indexPath.row].value(forKey: "average") as? Float
		let nameText = "\(name!)"
		let winText = "\(wins!)"
		let averageText = "\(average!.rounded(toPlaces: 2))"
		cell.nameLabel.text = nameText
		cell.gamesLabel.text = "\(games!)"
		cell.winLabel.text = winText
		cell.scoreAverageLabel.text = averageText
		cell.showStatsButton.tag = indexPath.row
		print("indexPath Value for cell: \(indexPath.row)")
		
		// Set highlited button:
		if selectedButtonTag != nil {
			if indexPath.row == selectedButtonTag {
				cell.showStatsButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 0.3519638271)
			} else {
				cell.showStatsButton.backgroundColor = UIColor.clear
			}
		}
		
		
		
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let playerName = allPlayersData[indexPath.row].value(forKey: "name") as? String ?? "Error"
		showPlayerStats(playerName: playerName)
	}
	
}
