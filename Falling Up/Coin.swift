//
//  Coin.swift
//  Falling Up
//
//  Created by Jasper Reddin on 11/30/15.
//  Copyright © 2015 Jasper Reddin. All rights reserved.
//

import SpriteKit

class Coin: SKSpriteNode {
	
	class func newCoin() -> Coin {
		let coin = Coin(imageNamed: "coin")
		coin.setScale(0.5)
		return coin
	}
	
}
