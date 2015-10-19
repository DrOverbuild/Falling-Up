//
//  GameScene.swift
//  Falling Up
//
//  Created by Jasper Reddin on 10/2/15.
//  Copyright (c) 2015 Jasper Reddin. All rights reserved.
//

import SpriteKit

extension SKScene {
	func minX() -> CGFloat{
		return CGRectGetMinX(self.frame)
	}
	
	func minY() -> CGFloat{
		return CGRectGetMinY(self.frame)
	}
	
	func maxX() -> CGFloat{
		return CGRectGetMaxX(self.frame)
	}
	
	func maxY() -> CGFloat{
		return CGRectGetMaxY(self.frame)
	}
	
	func midX() -> CGFloat{
		return CGRectGetMidX(self.frame)
	}
	
	func midY() -> CGFloat{
		return CGRectGetMidY(self.frame)
	}
	
	func moveToScene(scene: SKScene){
		self.moveToScene(scene, transition: true)
	}
	
	func moveToScene(scene: SKScene, transition: Bool){
		scene.scaleMode = .ResizeFill
		if let theView = self.view{
			scene.size = theView.bounds.size
			if transition{
				theView.presentScene(scene, transition: SKTransition.crossFadeWithDuration(0.3))
			}else{
				theView.presentScene(scene)

			}
		}
	}
	
	func playSoundEffect(filename:String){
		let sfxPrefs =	NSUserDefaults.standardUserDefaults().boolForKey("sfx_preference")
		if sfxPrefs {
			self.runAction(SKAction.playSoundFileNamed(filename, waitForCompletion: false))
		}
	}
}