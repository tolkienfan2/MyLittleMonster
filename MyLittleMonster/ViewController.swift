//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Minni K Ang on 2016-02-02.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var golem: UIButton!
	@IBOutlet weak var babyGolem: UIButton!
   
    @IBOutlet weak var monsterImg: MonsterImg!
	@IBOutlet weak var foodImg: DragImg!
	@IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var coinsImg: DragImg!

    @IBOutlet weak var choiceLabel: UILabel!
    var idleImage: String!
    var deadImage: String!
    
	@IBOutlet weak var penalty1Img: UIImageView!
	@IBOutlet weak var penalty2Img: UIImageView!
	@IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var replayButton: UIButton!
    
	let DIM_ALPHA: CGFloat = 0.2
	let OPAQUE: CGFloat = 1.0
	let MAX_PENALTIES = 3
	
	var penalties = 0
	var timer: NSTimer!
	var monsterHappy = false
	var currentItem: UInt32 = 0
	
	var musicPlayer: AVAudioPlayer!
	var sfxBite: AVAudioPlayer!
	var sfxHeart: AVAudioPlayer!
	var sfxDeath: AVAudioPlayer!
	var sfxSkull: AVAudioPlayer!
    var sfxCoins: AVAudioPlayer!
    
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		foodImg.dropTarget = monsterImg
		heartImg.dropTarget = monsterImg
        coinsImg.dropTarget = monsterImg
		dimPenalties()
        foodImg.alpha = DIM_ALPHA
        heartImg.alpha = DIM_ALPHA
        coinsImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.userInteractionEnabled = false
        coinsImg.userInteractionEnabled = false

        replayButton.hidden = true
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDropped:", name: "onTargetDropped", object: nil)
		
		do {
			try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
			try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
			try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
			try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
			try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            try sfxCoins = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("coins", ofType: "wav")!))
			
			musicPlayer.prepareToPlay()
			musicPlayer.play()
			
			sfxBite.prepareToPlay()
			sfxHeart.prepareToPlay()
			sfxDeath.prepareToPlay()
			sfxSkull.prepareToPlay()
            sfxCoins.prepareToPlay()

		} catch let error as NSError {
			print(error.debugDescription)
		}
	}
    
    @IBAction func chooseGolem(sender: AnyObject) {
        choiceLabel.hidden = true
        golem.hidden = true
        babyGolem.hidden = true
        monsterImg.setMonster("Golem")
        startGame()
    }
	
    @IBAction func chooseBabyGolem(sender: AnyObject) {
        choiceLabel.hidden = true
        golem.hidden = true
        babyGolem.hidden = true
        monsterImg.setMonster("BabyGolem")
        startGame()
     }
    
	func itemDropped(notif: AnyObject) {
		monsterHappy = true
		startTimer()
		
		foodImg.alpha = DIM_ALPHA
		heartImg.alpha = DIM_ALPHA
        coinsImg.alpha = DIM_ALPHA
		foodImg.userInteractionEnabled = false
		heartImg.userInteractionEnabled = false
        coinsImg.userInteractionEnabled = false
		
		if currentItem == 0 {
			sfxHeart.play()
		} else if currentItem == 1 {
			sfxBite.play()
        } else {
            sfxCoins.play()
        }
	}
	
	func startTimer() {
		if timer != nil {
			timer.invalidate()
		}
		
		timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
	}
	
	func dimPenalties() {
		penalty1Img.alpha = DIM_ALPHA
		penalty2Img.alpha = DIM_ALPHA
		penalty3Img.alpha = DIM_ALPHA
	}
	
	func changeGameState() {
		
		if !monsterHappy {
			
			penalties++
			sfxSkull.play()
		
		if penalties == 1 {
				penalty1Img.alpha = OPAQUE
			} else if penalties == 2 {
				penalty2Img.alpha = OPAQUE
			} else if penalties == 3 {
				penalty3Img.alpha = OPAQUE
			} else {
				dimPenalties()
			}
		
			if penalties >= MAX_PENALTIES {
				gameOver()
			}
		}
		
		let rand = arc4random_uniform(3)
		
		if rand == 0 {
			
			foodImg.alpha = DIM_ALPHA
			foodImg.userInteractionEnabled = false
			
			heartImg.alpha = OPAQUE
			heartImg.userInteractionEnabled = true
			
            coinsImg.alpha = DIM_ALPHA
            coinsImg.userInteractionEnabled = false

        } else if rand == 1 {
			
			foodImg.alpha = OPAQUE
			foodImg.userInteractionEnabled = true
			
			heartImg.alpha = DIM_ALPHA
			heartImg.userInteractionEnabled = false

            coinsImg.alpha = DIM_ALPHA
            coinsImg.userInteractionEnabled = false
			
        } else {
            coinsImg.alpha = OPAQUE
            coinsImg.userInteractionEnabled = true
            
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false

        }
		
		currentItem = rand
		monsterHappy = false
	}
	
	func gameOver() {
		timer.invalidate()
		monsterImg.playDeathAnimation(monsterImg.deadImage)
		sfxDeath.play()
        replayButton.hidden = false
	}
    
    @IBAction func replayGame(sender: AnyObject) {
        replayButton.hidden = true
        startGame()
    }
    
    func startGame() {
        penalties = 0
        dimPenalties()
        monsterImg.playIdleAnimation(monsterImg.idleImage)
        monsterHappy = false
        startTimer()
    }
}

