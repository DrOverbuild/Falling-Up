//
//  GameMenuScene.swift
//  
//
//  Created by Jasper Reddin on 8/11/15.
//
//

import SpriteKit

class GameMenuScene: SKScene {
	let logoSprite = SKSpriteNode(imageNamed: "logo")
	let playButton = SKSpriteNode(imageNamed: "playButton")
	let optionsButton = SKSpriteNode(imageNamed: "optionsButton")
	let highScoreLabel = SKLabelNode(fontNamed: "Arial Black")
	
	override func didMoveToView(view: SKView) {
		self.backgroundColor = UIColor.whiteColor()
		
		logoSprite.name = "logoSprite"
		logoSprite.position = CGPoint(x: midX(), y: maxY()-(logoSprite.frame.height/2)-20)
		let scale = (self.frame.width-40)/logoSprite.frame.width
		logoSprite.setScale(scale)
		self.addChild(logoSprite)
		
		playButton.name = "playButton"
		playButton.position = CGPoint(x: midX(), y: midY()/*+playButton.frame.height/2+5*/)
		playButton.setScale(0.5)
		self.addChild(playButton)
		
//		optionsButton.name = "optionsButton"
//		optionsButton.position = CGPoint(x: midX(), y: midY()-optionsButton.frame.height/2-5)
//		optionsButton.setScale(0.5)
//		self.addChild(optionsButton)
		
		let highScore = NSUserDefaults.standardUserDefaults().integerForKey("highScore")
		highScoreLabel.text = "High Score: \(highScore)"
		highScoreLabel.fontColor = UIColor.blackColor()
		highScoreLabel.fontSize = 30
		highScoreLabel.position = CGPoint(x: maxX()-highScoreLabel.frame.width/2-20, y: minY()+20)
		self.addChild(highScoreLabel)
		
		//self.runAction(SKAction.playSoundFileNamed("buttonPress.wav", waitForCompletion: false))

	}
	
	override func update(currentTime: NSTimeInterval) {
		updatePositions()
	}
	
	func updatePositions(){
		logoSprite.position = CGPoint(x: midX(), y: maxY()-(logoSprite.frame.height/2)-20)
		//logoSprite.setScale((self.frame.width-40)/logoSprite.frame.width)
		
		playButton.position = CGPoint(x: midX(), y: midY()/*+playButton.frame.height/2+5*/)

		//optionsButton.position = CGPoint(x: midX(), y: midY()-optionsButton.frame.height/2-5)
		
		highScoreLabel.position = CGPoint(x: maxX()-highScoreLabel.frame.width/2-20, y: minY()+20)
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		/* Called when a touch begins */
		
		for touch in touches {
			let location = touch.locationInNode(self)
			
			let clickedNode = self.nodeAtPoint(location)
			if clickedNode == playButton{
				// Open InGameScene
				playSoundEffect("score.wav")
				moveToScene(InGameScene())
			}
			
			if clickedNode == optionsButton{
				// Open OptionsScene
			}
		}
	}
}
