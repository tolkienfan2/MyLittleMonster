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
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		playIdleAnimation()
	}
	
	func playIdleAnimation() {
		
		self.image = UIImage(named: "idle1")
		self.animationImages = nil

		var imgArray = [UIImage]()
		for var x = 1; x <= 4; x++ {
			let img = UIImage(named: "idle\(x)")
			imgArray.append(img!)
		}

		self.animationImages = imgArray
		self.animationDuration = 0.8
		self.animationRepeatCount = 0
		self.startAnimating()
	}
	
	func playDeathAnimation() {

		self.image = UIImage(named: "dead5")
		self.animationImages = nil
		
		var imgArray = [UIImage]()
		for var x = 1; x <= 5; x++ {
			let img = UIImage(named: "dead\(x)")
			imgArray.append(img!)
		}
		
		self.animationImages = imgArray
		self.animationDuration = 0.8
		self.animationRepeatCount = 1
		self.startAnimating()
	}
}