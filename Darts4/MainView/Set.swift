//
//  Set.swift
//  Darts4
//
//  Created by 古賀ミッシェル on 2018/10/08.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation

struct Set {
	
	var playerA: String
	var playerB: String
	
	var scoreA: String
	var scoreB: String
	
	var toGoA: String
	var toGoB: String
	
	var turnNumber: String
	
	var isBurst = false
	var isLast = false
}
struct Game {
	var sets = [Set]()
	
}
