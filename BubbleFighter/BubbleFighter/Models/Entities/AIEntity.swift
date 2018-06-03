//
//  AIEntity.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


public class AIEntity: CharacterEntity {

    override init() {
        super.init()

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
