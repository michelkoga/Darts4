//
//  UnderGraphsView.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/24.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit
import CoreData

class UnderGraphsView: MotherGraphsView {
	
	
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
	
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		print("Here is 1")
		if self.layer.bounds.width > 700.0 {
			let minX: CGFloat = 0.0
			//			let midX = self.layer.bounds.midX
			let maxX = self.layer.bounds.maxX
			
			let minY = self.layer.bounds.maxY
			//			let midY = self.layer.bounds.midY
			let maxY: CGFloat = 0.0
			
			
			// Frame Rectangle:
			let rectPoint1 = CGPoint(x: minX, y: minY)
			let rectPoint2 = CGPoint(x: minX, y: maxY)
			let rectPoint3 = CGPoint(x: maxX, y: maxY)
			let rectPoint4 = CGPoint(x: maxX, y: minY)
			
			let rectLine = UIGraphicsGetCurrentContext()
			rectLine?.setLineWidth(2)
			rectLine?.setStrokeColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
			
			rectLine?.move(to: rectPoint1)
			rectLine?.addLine(to: rectPoint2)
			rectLine?.addLine(to: rectPoint3)
			rectLine?.addLine(to: rectPoint4)
			rectLine?.addLine(to: rectPoint1)
			
			rectLine?.strokePath()
			
			
			// Labels:
			fetchAllPlayers()
			if allPlayersData == [] { print("allPlayersData empty?"); return }
			print("Player Index is \(playerIndex)")
			let playerData = allPlayersData[playerIndex]
			
			guard let matchesAverages: Float = (playerData.value(forKey: "average") as? Float) else { return }
			print("matchesAverages: \(matchesAverages)")
			for case let label as UILabel in self.subviews {
				if label.tag == 1 {
					label.text = String("Average: \(matchesAverages)")
					print(matchesAverages)
				}
			}
		}
	}
	
	
}

