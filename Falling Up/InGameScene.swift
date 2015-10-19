//
//  InGameScene.swift
//  
//
//  Created by Jasper Reddin on 8/11/15.
//
//

import SpriteKit

class InGameScene: SKScene {
	let INITIAL_BALL_SPEED: CGFloat = 8
	var BAR_SPEED: CGFloat = 7
	var MIN_DISTANCE_BETWEEN_BARS: CGFloat = 225
	let BAR_WIDTH: CGFloat = 10
	let BALL_RADIUS: CGFloat = 25
	let BALL_ACCELERATION: CGFloat = 1
	let BAR_ACCELERATION: CGFloat = 0.004
	
	var box1: SKShapeNode!
	var box2: SKShapeNode!
	var ball: SKShapeNode!
	var scoreLabel: SKLabelNode!
	var gameOverLabel: SKLabelNode!
	var highScoreLabel: SKLabelNode!
	
	var BALL_SPEED: CGFloat = 0
	var score = 0
	var highScore = 0
	var direction: CGFloat = -1
	var bars: [Bar] = []
	var distanceFromLastBar: CGFloat = 0
	//var speedMultiplier: CGFloat = 1
	var gameOver = false
	var userIsTouching = false
	
	override func didMoveToView(view: SKView) {
		self.backgroundColor = UIColor.lightGrayColor()
		BALL_SPEED = INITIAL_BALL_SPEED
		
		self.physicsWorld.gravity = CGVectorMake(0, 0)
		
		box1 = SKShapeNode(rectOfSize: CGSize(width: self.frame.width, height: 50))
		box1.fillColor = UIColor.blackColor()
		box1.strokeColor = UIColor.blackColor()
		box1.position = CGPoint(x: midX(), y: maxY()-box1.frame.height/2+1)
		self.addChild(box1)
		
		box2 = SKShapeNode(rectOfSize: CGSize(width: self.frame.width, height: 50))
		box2.fillColor = UIColor.blackColor()
		box2.strokeColor = UIColor.blackColor()
		box2.position = CGPoint(x: midX(), y: minY()+25)
		self.addChild(box2)
		
		ball = SKShapeNode(circleOfRadius: BALL_RADIUS)
		ball.physicsBody = SKPhysicsBody(circleOfRadius: BALL_RADIUS)
		ball.fillColor = UIColor.whiteColor()
		ball.strokeColor = UIColor.whiteColor()
		ball.position = CGPoint(x: minX()+100, y: midY())
		self.addChild(ball)
		
		scoreLabel = SKLabelNode(fontNamed: "Arial Black")
		scoreLabel.text = "Score: 0"
		scoreLabel.fontSize = 25
		scoreLabel.position = CGPoint(x: minX()+scoreLabel.frame.width/2+20, y: box1.position.y-scoreLabel.frame.height/2)
		self.addChild(scoreLabel)
		
		gameOverLabel = SKLabelNode(fontNamed: "Arial Black")
		gameOverLabel.text = "Game over."
		gameOverLabel.fontSize = 25
		gameOverLabel.position = CGPoint(x: minX()+gameOverLabel.frame.width/2+20, y: box2.position.y+gameOverLabel.frame.height/2)
		
		highScore = NSUserDefaults.standardUserDefaults().integerForKey("highScore")
		
		highScoreLabel = SKLabelNode(fontNamed: "Arial Black")
		highScoreLabel.text = "High Score: \(highScore)"
		highScoreLabel.fontSize = 25
		highScoreLabel.position = CGPoint(x: maxX()-highScoreLabel.frame.width/2+10, y: box2.position.y+highScoreLabel.frame.height/2)
		self.addChild(highScoreLabel)
		

	}
	
	override func update(currentTime: NSTimeInterval) {
		if !gameOver{
			updateBars()
			updateBall()
			checkForCollision()
		}
		updatePositions()
	}
	
	func updatePositions(){
		box1.position = CGPoint(x: midX(), y: maxY()-box1.frame.height/2 + 1)
		box2.position = CGPoint(x: midX(), y: minY()+25)
		updateLabelPositions()
	}
	
	func updateLabelPositions(){
		scoreLabel.position = CGPoint(x: minX()+scoreLabel.frame.width/2+10, y: box1.position.y-scoreLabel.frame.height/2)
		gameOverLabel.position = CGPoint(x: minX()+gameOverLabel.frame.width/2+10, y: box2.position.y-gameOverLabel.frame.height/2)
		highScoreLabel.position = CGPoint(x: maxX()-highScoreLabel.frame.width/2-10, y: box2.position.y-highScoreLabel.frame.height/2)
	}
	
	func updateBars(){
		var barsToRemove: [Int] = []
		for (i,bar) in bars.enumerate(){
			bar.position.x -= BAR_SPEED
			if(bar.position.x+bar.frame.width/2<minX()){
				barsToRemove.append(i)
			}
			if !bar.hasPassedBall && bar.position.x < ball.position.x{
				bar.hasPassedBall = true
				score++
				scoreLabel.text = ("Score: \(score)")
				if score>highScore{
					highScore = score
					NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey: "highScore")
					highScoreLabel.text = "High Score: \(highScore)"
				}
			}
		}
		
		for index in barsToRemove{
			let bar = bars.removeAtIndex(index)
			bar.removeFromParent()
		}
		
		distanceFromLastBar+=BAR_SPEED
		
		if distanceFromLastBar > MIN_DISTANCE_BETWEEN_BARS{
			let random1 = arc4random() % 2
			if(random1 == 1){
				addBar()
			}
		}
		
		BAR_SPEED += BAR_ACCELERATION
		MIN_DISTANCE_BETWEEN_BARS += BAR_ACCELERATION * 2
		
	}
	
	func addBar(){
		let barHeightLimit = (box1.position.y-box1.frame.height)-(box2.position.y+box2.frame.height/2)-BALL_RADIUS-40
		let random2 = arc4random() % UInt32(barHeightLimit)
		let random3 = arc4random() % 2
		let bar = Bar(rectOfSize: CGSize(width: BAR_WIDTH, height: CGFloat(random2+20)))
		bar.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: BAR_WIDTH, height: CGFloat(random2 + 20)))
		bar.fillColor = UIColor.blackColor()
		bar.strokeColor = UIColor.blackColor()
		var yPos: CGFloat = 0
		if random3 == 0{
			yPos = (box1.position.y-box1.frame.height/2-bar.frame.height/2)+5
		}else{
			yPos = (box2.position.y+box2.frame.height/2+bar.frame.height/2)-5
		}
		bar.position = CGPoint(x: maxX(), y: yPos)
		bars.append(bar)
		self.addChild(bar)
		distanceFromLastBar = 0
	}
	
	func updateBall(){
		ball.position.y += (BALL_SPEED*direction)
		if ball.frame.intersects(box1.frame){
			ball.position.y = box1.position.y - (box1.frame.height / 2) - (ball.frame.height / 2)
			BALL_SPEED = INITIAL_BALL_SPEED
		}
		
		if ball.frame.intersects(box2.frame){
			ball.position.y = box2.position.y + (box2.frame.height / 2) + (ball.frame.height / 2)
			BALL_SPEED = INITIAL_BALL_SPEED
		}
		if userIsTouching {
			BALL_SPEED += BALL_ACCELERATION
		}else{
			if BALL_SPEED > INITIAL_BALL_SPEED{
				BALL_SPEED -= BALL_ACCELERATION
			}
		}
	}
	
	func checkForCollision(){
		if ball.physicsBody!.allContactedBodies().count > 0{
			gameOver = true
			playSoundEffect("death.wav")
			addChild(gameOverLabel)
			NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey: "highScore")
		}
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		/* Called when a touch begins */
		
		userIsTouching = true
		
		playSoundEffect("score.wav")
		
		for _ in touches {
			if(!gameOver){
				direction *= -1
				BALL_SPEED = INITIAL_BALL_SPEED
				
			}else{
				moveToScene(GameMenuScene())
			}
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		userIsTouching = false
	}
}

class Bar: SKShapeNode{
	var hasPassedBall = false
}
