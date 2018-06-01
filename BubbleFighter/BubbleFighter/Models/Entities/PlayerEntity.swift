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
    
    private var moveUpNode : SKNode!
    private var moveDownNode : SKNode!
    private var moveLeftNode : SKNode!
    private var moveRightNode : SKNode!
    
    override init() {
        super.init()
        
        moveUpNode = SKLabelNode(text: "Up")
        moveDownNode = SKLabelNode(text: "Down")
        moveLeftNode = SKLabelNode(text: "Left")
        moveRightNode = SKLabelNode(text: "Right")
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
