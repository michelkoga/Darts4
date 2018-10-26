//
//  Languages.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/15.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation

class Language {
	fileprivate static let defaults = UserDefaults.standard
	// Main View:
	fileprivate static var player = "Player"
	fileprivate static var team = "Team"
	
	// Settings View:
	fileprivate static var language = "Language"
	fileprivate static var reset = "Reset"
	fileprivate static var turns = " Turns"
	fileprivate static var done = " Done"
	fileprivate static var starting = "Starting"
	fileprivate static var points = " Points"
	fileprivate static var players = " Players"
	fileprivate static var score = "Score"
	fileprivate static var cancel = "Cancel"
	
	// Keyboard View:
	fileprivate static var settings = "Settings"
	// Same fileprivate static var resetK = "Reset"
	
	fileprivate static var labels = [player, team]
	
	fileprivate static func setLanguageDefaults(lang: String) {
		switch lang {
		case "English":
			score = "Score"
			player = "Team "
			team = "Team"
			language = "Language"
			reset = "Reset"
			turns = " Turns"
			done = "Done"
			starting = "Starting: "
			points = " Points"
			players = " Players"
			cancel = "Cancel"
		// Keyboard View:
			settings = "Settings"
			//reset = same
		case "Japanese":
			score = "点数"
			player = "チーム　"
			team = "チーム"
			language = "言語"
			reset = "リセット"
			turns = "回"
			done = "完了"
			starting = "スタート："
			points = "点から"
			players = "名"
			cancel = "キャンセル"
			// Keyboard View:
			settings = "設定"
			// resetK = same
		case "Portuguese":
			score = "Pontos"
			player = "Team "
			team = "Time"
			language = "Língua"
			reset = "Reset"
			turns = " Rondas"
			done = "Concluir"
			starting = "Início: "
			points = " Pontos"
			players = " Jogadores"
			cancel = "Cancelar"
			// Keyboard View:
			settings = "Configurações"
			//resetK = "Reset" Same
		default:
			break
		}
		defaults.set(player, forKey: "playerLabel")
		defaults.set(team, forKey: "teamLabel")
		defaults.set(language, forKey: "languageLabel")
		defaults.set(reset, forKey: "resetLabel")
		defaults.set(turns, forKey: "turnsLabel")
		defaults.set(done, forKey: "doneLabel")
		defaults.set(starting, forKey: "startingLabel")
		defaults.set(points, forKey: "pointsLabel")
		defaults.set(players, forKey: "playersLabel")
		defaults.set(settings, forKey: "settingsLabel")
		defaults.set(cancel, forKey: "cancelLabel")
		
	}
	
	
	// Languages:
	static var labelsLanguage: String = "English" {
		didSet {
			Language.setLanguageDefaults(lang: labelsLanguage)
		}
	}
}
