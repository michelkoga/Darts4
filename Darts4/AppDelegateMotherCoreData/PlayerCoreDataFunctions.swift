//
//  PlayerCoreDataFunctions.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/08.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation
import CoreData

extension ScoreViewController {
	func coreDataEnterNewPlayer(name: String) {
		if name == "" {
			print("text field empty.")
			return
		}
		let context = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Players", in: context)
		let newPlayer = NSManagedObject(entity: entity!, insertInto: context)
		
		//		let newPlayerName = nameField.text!
		if playerIsNew(newPlayer: name) {
			newPlayer.setValue(name, forKey: "name")
			do {
				try context.save()
			} catch {
				print("Save Fail")
			}
		}
	}
	func coreDatagetData() -> [(String, [Int])] {
		
		let context = appDelegate.persistentContainer.viewContext
		
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
		//request.predicate = NSPredicate(format: "age = %@", "12")
		request.returnsObjectsAsFaults = false
		do {
			var results = [(String(),[Int]())]
			let result = try context.fetch(request)
			for data in result as! [NSManagedObject] {
				if let name = data.value(forKey: "name"), let scores = data.value(forKey: "scores") {
					results.append((name as! String, scores as! [Int]))
				}
			}
			return results
			
		} catch {
			
			print("Failed")
		}
		return []
	}
	func coreDatagetPlayers() -> [String] {
		let context = appDelegate.persistentContainer.viewContext
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
		//request.predicate = NSPredicate(format: "age = %@", "12")
		request.returnsObjectsAsFaults = false
		do {
			var results = [String]()
			let result = try context.fetch(request)
			for data in result as! [NSManagedObject] {
				if let name = data.value(forKey: "name") {
					results.append(name as! String)
				}
			}
			return results
			
		} catch {
			
			print("Failed")
		}
		return []
	}
	func coreDataselectPlayerScores(of player: String) -> [Int] {
		let context = appDelegate.persistentContainer.viewContext
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
		request.returnsObjectsAsFaults = false
		do {
			var results = [Int]()
			let result = try context.fetch(request)
			for data in result as! [NSManagedObject] {
				if let name = data.value(forKey: "name"), let scores = data.value(forKey: "scores") {
					if name as! String == player {
						for score in scores as! [Int] {
							results.append(score)
						}
						return results
					}
				}
			}
		} catch {
			print("selectPlayerScores function failed.")
		}
		return []
	}
	
	// Helpers
	fileprivate func playerIsNew(newPlayer: String) -> Bool {
		let context = appDelegate.persistentContainer.viewContext
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
		request.returnsObjectsAsFaults = false
		do {
			let result = try context.fetch(request)
			for player in result as! [NSManagedObject] {
				if let name = player.value(forKey: "name") {
					if name as! String == newPlayer {
						return false
					}
				}
			}
		} catch {
			print("Failed in checkIfPlayerAlreadyExist function.")
		}
		return true
	}
}
