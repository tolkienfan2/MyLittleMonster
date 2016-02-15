//
//  MonsterImg.swift
//  MyLittleMonster
//
//  Created by Minni K Ang on 2016-02-03.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    var name: String!
    var idleImage: String!
    var deadImage: String!
    
    override init(frame: CGRect) {
		super.init(frame: frame)
 	}
	
    required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
    }
    
    func setMonster(name: String) {
        self.name = name
        
        if name == "Golem" {
            self.idleImage = "idle"
            self.deadImage = "dead"
            
        } else if name == "BabyGolem" {
            self.idleImage = "baby"
            self.deadImage = "faint"
        }
    }
	
    func playIdleAnimation(monsterImg: String) {
		
		self.image = UIImage(named: monsterImg + "1")
		self.animationImages = nil

		var imgArray = [UIImage]()
		for var x = 1; x <= 4; x++ {
			let img = UIImage(named: monsterImg + "\(x)")
			imgArray.append(img!)
		}

		self.animationImages = imgArray
		self.animationDuration = 0.8
		self.animationRepeatCount = 0
		self.startAnimating()
	}
	
    func playDeathAnimation(deadImg: String) {

		self.image = UIImage(named: deadImg + "5")
		self.animationImages = nil
		
		var imgArray = [UIImage]()
		for var x = 1; x <= 5; x++ {
			let img = UIImage(named: deadImg + "\(x)")
			imgArray.append(img!)
		}
		
		self.animationImages = imgArray
		self.animationDuration = 0.8
		self.animationRepeatCount = 1
		self.startAnimating()
	}
}