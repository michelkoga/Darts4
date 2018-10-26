//
//  PlayersTableDelegate.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/09.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("AllPlayersData.count is \(allPlayersData.count)")
		return allPlayersData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerSearchCell") as? SearchTable else {
			return UITableViewCell()
		}
		cell.name.text = allPlayersData[indexPath.row].value(forKeyPath: "name") as? String  //allPlayers[indexPath.row]
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let playerName = allPlayersData[indexPath.row].value(forKey: "name") as? String ?? "Error"
		setPlayerToButton(playerName: playerName)
		selectNextPlayer()
	}
	// Swipes:
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
			completion(true)
		}
		action.backgroundColor = .red
		
		return UISwipeActionsConfiguration(actions: [action]
		)
	}
}

