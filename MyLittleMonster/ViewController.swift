//
//  ViewController.swift
//  MyLittleMonster
//
//  Created by Minni K Ang on 2016-02-02.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
	
	@IBOutlet weak var monsterImg: MonsterImg!
	@IBOutlet weak var foodImg: DragImg!
	@IBOutlet weak var heartImg: DragImg!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		foodImg.dropTarget = monsterImg
		heartImg.dropTarget = monsterImg
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDropped:", name: "onTargetDropped", object: nil)
	}
	
	func itemDropped(notif: AnyObject) {
		print("item dropped on character")
	}
}

