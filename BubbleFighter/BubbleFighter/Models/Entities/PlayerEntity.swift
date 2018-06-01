//
//  PlayerEntity.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/1.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class PlayerEntity: CharacterEntity {
    
    override init() {
        super.init()
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
