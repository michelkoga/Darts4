//
//  GraphsView.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/23.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import UIKit
import CoreData

class GraphsView: MotherGraphsView {
	
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
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		
		// min max
		let minX: CGFloat = self.layer.bounds.minX
		let minY: CGFloat = self.layer.bounds.minY
		//		let midX = self.layer.bounds.midX
		let maxX = self.layer.bounds.maxX
		//		let minY = self.layer.bounds.minY
		//		let midY = self.layer.bounds.midY
		let maxY: CGFloat = self.layer.bounds.maxY
		print("coreDataPlayerIndex is : \(playerIndex)")
		
		
		
		fetchAllPlayers()
		if allPlayersData == [] { print("allPlayersData empty?"); return }
		let playerData = allPlayersData[playerIndex]
		
		// Build Real Graphics:
		let matchesAverages: [Float] = (playerData.value(forKey: "matchAverages") as? [Float]) ?? []
		var averageTotal: CGFloat = 0
		var sumAverages: CGFloat = 0
		if (matchesAverages.count) > 1 {
			
			// Find Biggest average:
			var biggestAverage: Float = 50
			for average in matchesAverages {
				sumAverages = sumAverages + CGFloat(average)
				if average > biggestAverage {
					biggestAverage = average
				}
			}
			averageTotal = sumAverages / CGFloat(matchesAverages.count)
			// Find Smallest average:
			var smallestAverage = biggestAverage
			for average in matchesAverages {
				if average < smallestAverage {
					smallestAverage = average
				}
			}
			//			let midleY = biggestAverage - ((biggestAverage + smallestAverage) / 2)
			//			let factor = 3
			
			print(" ")
			print("***** ***** *****")
			let yUnit = 0.8 * self.layer.bounds.maxY / CGFloat(biggestAverage - smallestAverage)
			print("yUnit is \(yUnit)")
			
			var x = minX
			let unit = maxX / CGFloat(matchesAverages.count)
			
			let graph = UIGraphicsGetCurrentContext()
			graph?.setLineWidth(2)
			graph?.setStrokeColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
			// preprare first value:
			let newY = (CGFloat(matchesAverages[0] - smallestAverage) * yUnit) + 10
			let invertY = maxY - newY
			let newAverageY = ((averageTotal - CGFloat(smallestAverage)) * yUnit) + 10
			let invertedAverageY = maxY - newAverageY
			
			// MARK:  Create straight lines
			// Each 1 points Line:
			for unit in 1...180 {
				let multiplier = unit
				let pointY = ((CGFloat(multiplier) - CGFloat(smallestAverage)) * yUnit) + 10
				let invertedY = maxY - pointY
				let startPoint = CGPoint(x: minX, y: invertedY)
				let endPoint = CGPoint(x: maxX, y: invertedY)
				
				let line = UIGraphicsGetCurrentContext()
				if multiplier % 5 == 0 {
					line?.setLineWidth(0.7)
				} else {
					line?.setLineWidth(0.2)
				}
				line?.setStrokeColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
				line?.move(to: startPoint)
				line?.addLine(to: endPoint)
				line?.strokePath()
			}
			
			// Each 10 points Line:
			for unit in 1...180 {
				let multiplier = unit * 10
				let pointY = ((CGFloat(multiplier) - CGFloat(smallestAverage)) * yUnit) + 10
				let invertedY = maxY - pointY
				let startPoint = CGPoint(x: minX, y: invertedY)
				let endPoint = CGPoint(x: maxX, y: invertedY)
				
				let line = UIGraphicsGetCurrentContext()
				line?.setLineWidth(1)
				line?.setStrokeColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
				switch multiplier {
				case 30:
					line?.setLineWidth(2)
					line?.setStrokeColor(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))
				case 50:
					line?.setLineWidth(2)
					line?.setStrokeColor(#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))
				case 70:
					line?.setLineWidth(2)
					line?.setStrokeColor(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))
				case 100:
					line?.setLineWidth(2)
					line?.setStrokeColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
				case 120:
					line?.setLineWidth(2)
					line?.setStrokeColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
				case 140:
					line?.setLineWidth(2)
					line?.setStrokeColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
				default:
					break
				}
				line?.move(to: startPoint)
				line?.addLine(to: endPoint)
				line?.strokePath()
			}
			// Set Mid point Line:
			let startMidPoint = CGPoint(x: minX, y: invertedAverageY)
			let endMidPoint = CGPoint(x: maxX, y: invertedAverageY)
			
			let midLine = UIGraphicsGetCurrentContext()
			midLine?.setLineWidth(2)
			midLine?.setStrokeColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
			midLine?.move(to: startMidPoint)
			midLine?.addLine(to: endMidPoint)
			
			midLine?.strokePath()
			
			
			
			
			
			
			
			// MARK: Create Graphics
			let cgPoint = CGPoint(x: x, y: invertY)
			
			graph?.move(to: cgPoint)
			graph?.setStrokeColor(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1))
			for average in matchesAverages {
				x = x + unit
				print( "Average: \(average)", terminator: ", ")
				let newY = (CGFloat(average - smallestAverage) * yUnit) + 10
				print("NewY: \(newY)", terminator: ", ")
				let invertY = maxY - newY
				let cgPoint = CGPoint(x: x, y: invertY)
				print("Inverted Y: \(invertY)", terminator: "; ")
				graph?.addLine(to: cgPoint)
			}
			print(" ")
			print("***** ***** *****")
			graph?.strokePath()
			print("Ended")
			
			
			// MARK: Frame Rectangle: Has to Be in the end
			let rectPoint1 = CGPoint(x: minX, y: minY)
			let rectPoint2 = CGPoint(x: minX, y: maxY)
			let rectPoint3 = CGPoint(x: maxX, y: maxY)
			let rectPoint4 = CGPoint(x: maxX, y: minY)
			
			let rectLine = UIGraphicsGetCurrentContext()
			rectLine?.setLineWidth(4)
			rectLine?.setStrokeColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
			
			rectLine?.move(to: rectPoint1)
			rectLine?.addLine(to: rectPoint2)
			rectLine?.addLine(to: rectPoint3)
			rectLine?.addLine(to: rectPoint4)
			rectLine?.addLine(to: rectPoint1)
			
			rectLine?.strokePath()
//			// Set 50 points Line:
//			let point50Y = ((50 - CGFloat(smallestAverage)) * yUnit) + 10
//			let inverted50Y = maxY - point50Y
//			let start50Point = CGPoint(x: minX, y: inverted50Y)
//			let end50Point = CGPoint(x: maxX, y: inverted50Y)
//
//			let line50 = UIGraphicsGetCurrentContext()
//			line50?.setLineWidth(2)
//			line50?.setStrokeColor(#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1))
//			line50?.move(to: start50Point)
//			line50?.addLine(to: end50Point)
//			line50?.strokePath()
//
//			// Set 100 points Line:
//			let point100Y = ((100 - CGFloat(smallestAverage)) * yUnit) + 10
//			let inverted100Y = maxY - point100Y
//			let start100Point = CGPoint(x: minX, y: inverted100Y)
//			let end100Point = CGPoint(x: maxX, y: inverted100Y)
//
//			let line100 = UIGraphicsGetCurrentContext()
//			line100?.setLineWidth(2)
//			line100?.setStrokeColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
//			line100?.move(to: start100Point)
//			line100?.addLine(to: end100Point)
//			line100?.strokePath()
//
//			// Set 120 points Line:
//			let point120Y = ((120 - CGFloat(smallestAverage)) * yUnit) + 10
//			let inverted120Y = maxY - point120Y
//			let start120Point = CGPoint(x: minX, y: inverted120Y)
//			let end120Point = CGPoint(x: maxX, y: inverted120Y)
//
//			let line120 = UIGraphicsGetCurrentContext()
//			line120?.setLineWidth(2)
//			line120?.setStrokeColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
//			line120?.move(to: start120Point)
//			line120?.addLine(to: end120Point)
//			line120?.strokePath()
//
//			// Set 140 points Line:
//			let point140Y = ((140 - CGFloat(smallestAverage)) * yUnit) + 10
//			let inverted140Y = maxY - point140Y
//			let start140Point = CGPoint(x: minX, y: inverted140Y)
//			let end140Point = CGPoint(x: maxX, y: inverted120Y)
//
//			let line140 = UIGraphicsGetCurrentContext()
//			line140?.setLineWidth(2)
//			line140?.setStrokeColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
//			line140?.move(to: start140Point)
//			line140?.addLine(to: end140Point)
//			line140?.strokePath()
//
			
		}
		
		
	}
	
	
}

