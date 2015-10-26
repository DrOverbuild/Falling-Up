//
//  GameViewController.swift
//  Falling Up
//
//  Created by Jasper Reddin on 10/2/15.
//  Copyright (c) 2015 Jasper Reddin. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation.AVAudioSession

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		do{
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
		}catch{}
		
		
		
		let music = NSUserDefaults.standardUserDefaults().boolForKey("music_preference")
		if music {
			playBackgroundMusic("music.mp3")
		}
		
		let resetData = NSUserDefaults.standardUserDefaults().boolForKey("reset_data")
		if resetData {
			NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highScore")
			NSUserDefaults.standardUserDefaults().setBool(false, forKey: "reset_data")
		}
		
		print("music = \(music)")
		print("resetData = \(resetData)")
		
		let skView = self.view as! SKView
		let level = GameMenuScene()
		level.scaleMode = .ResizeFill
		level.size = skView.bounds.size
		skView.presentScene(level)
		
//        if let scene = GameScene(fileNamed:"GameScene") {
//            // Configure the view.
//            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            
//            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//            
//            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .AspectFill
//            
//            skView.presentScene(scene)
//			
//        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        //if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
		return .Landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
