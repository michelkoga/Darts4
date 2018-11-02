//
//  MotherViewController.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/09.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit
import CoreData

class MotherViewController: UIViewController {
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	// MARK: - Core Data:
//	var resultsController: NSFetchedResultsController<Game>!
//	let coreDataStack = CoreDataStack()
	let defaults = UserDefaults.standard
	var allPlayersDataSelectedRow = 0
	// ********* User Defaults ****************
	// For players Stats Data: scores, legs(wins?), average, games
	var playersScores: [(player: String, scores: [Int])] {
		get {
			if defaults.contains(key: "playersScores") {
				return defaults.array(forKey: "playersScores") as! [(player: String, scores: [Int])]
			} else {
				return []
			}
		}
		set {
			defaults.set(newValue, forKey: "playersScores")
		}
	}
	
	
	
	
	// Basic Data:
	
	fileprivate func setMaxScore(for startingScore: Int) {
		switch startingScore {
		case 151, 251:
			defaults.set(50, forKey: "minNiceValue")
			defaults.set(90, forKey: "maxScore")
		case 301,501,701,1001:
			defaults.set(100, forKey: "minNiceValue")
			defaults.set(180, forKey: "maxScore")
		default:
			break
		}
	}
	
	var startingToGo: Int {
		get {
			if defaults.contains(key: "startingScore") {
				return defaults.integer(forKey: "startingScore")
			} else {
				return 251
			}
		}
		set {
			defaults.set(newValue, forKey: "startingScore")
			setMaxScore(for: newValue)
		}
	}
	
	var turnsNumber: Int {
		get {
			if defaults.contains(key: "turnsNumber") {
				return defaults.integer(forKey: "turnsNumber")
			} else {
				return 12
			}
		}
		set {
			defaults.set(newValue, forKey: "turnsNumber")
		}
	}
	var legsLimit: Int {
		get {
			if defaults.contains(key: "legsLimit") {
				return defaults.integer(forKey: "legsLimit")
			} else {
				return 1
			}
		}
		set {
			defaults.set(newValue, forKey: "legsLimit")
		}
	}
	var setsNumber: Int {
		get {
			if defaults.contains(key: "setsNumber") {
				return defaults.integer(forKey: "setsNumber")
			} else {
				return 1
			}
		}
		set {
			defaults.set(newValue, forKey: "setsNumber")
			legsLimit = 1 + (setsNumber / 2)
		}
	}
	var playersNumber: Int {
		get {
			if defaults.contains(key: "playersNumber") {
				return defaults.integer(forKey: "playersNumber")
			} else {
				return 2
			}
		}
		set {
			defaults.set(newValue, forKey: "playersNumber")
		}
	}
//	var currentNameArray = [String]()
	
	var playersA: [String] {
		get {
			if defaults.contains(key: "playersA") {
				return defaults.array(forKey: "playersA") as! [String]
			} else {
				// print("Doens't contain players")
				playersNumber = 2
				return ["Player 1"]
			}
		}
		set {
			defaults.set(newValue, forKey: "playersA")
			let p = defaults.array(forKey: "playersA") as! [String]
			for player in p { print(player, terminator: ", ") }
			print(" ")
		}
	}
	var playersB: [String] {
		get {
			if defaults.contains(key: "playersB") {
				return defaults.array(forKey: "playersB") as! [String]
			} else {
				// print("Doens't contain players")
				playersNumber = 2
				return ["Player 2"]
			}
		}
		set {
			defaults.set(newValue, forKey: "playersB")
			let p = defaults.array(forKey: "playersB") as! [String]
			for player in p { print(player, terminator: ", ") }
			print(" ")
		}
	}
	var allPlayers: [String] {
		get {
			if defaults.contains(key: "allPlayers") {
				return defaults.array(forKey: "allPlayers") as! [String]
			} else {
				// print("Doens't contain players")
				return []
			}
		}
		set {
			
		}
	}
	// MARK: CORE DATA:
	var allPlayersData: [NSManagedObject] = []
	func saveNewPlayer(name: String) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		let context = appDelegate.persistentContainer.viewContext
		
		let entity = NSEntityDescription.entity(forEntityName: "Player", in: context)!
		let player = NSManagedObject(entity: entity, insertInto: context)
		player.setValue(name, forKey: "name")
		
		do {
			try context.save()
			print("Saved")
			allPlayers.append(name)
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	func fetchAllPlayers()  {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		let context = appDelegate.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Player")
		
		do {
			allPlayersData = try context.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
	}
	
	// ********** Input Holder **********
	var inputHolder = ""
	// ********** 1 Players Turn Pointer: **********
	var teamTurn = 0
	var row = 1
	
	var toGoesA = [Int?]()
	var toGoesB = [Int?]()
	
	var scoresA = [Int?]() // -1 is burst
	var scoresB = [Int?]()
	
	var stateA = [Int]()  // 0 is normal, 1 dart, 2 is burst
	var stateB = [Int]()
	// **************************************
	// ***** Core Data *****
//	var context: NSManagedObjectContext!
//	override func viewDidLoad() {
//        super.viewDidLoad()
//		let app = UIApplication.shared
//		let appDelegate = app.delegate as! AppDelegate
//		context = appDelegate.context
//		
//		// MARK: Data Core in viewDidLoad
//		// Request
//		let request: NSFetchRequest<Game> = Game.fetchRequest()
//		let sortDescriptors = NSSortDescriptor(key: "date", ascending: true)
//		
//		// Init
//		request.sortDescriptors = [sortDescriptors]
//		resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
//		do {
//			try resultsController.performFetch()
//		} catch {
//			print("Perform fetch error: \(error)")
//		}
//    }
	
	var context: NSManagedObjectContext!
	override func viewDidLoad() {
        super.viewDidLoad()
		let app = UIApplication.shared
		let appDelegate = app.delegate as! AppDelegate
		context = appDelegate.context
		
		
    }
}
