//
//  CharacterEntity.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/5/28.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class CharacterEntity : GKEntity {
    
    public let characterComponent = CharacterComponent()
    public let skNodeComponent = GKSKNodeComponent(node: SKSpriteNode())
    
    public var node : SKSpriteNode {
        return self.skNodeComponent.node as! SKSpriteNode
    }
    
    override init() {
        super.init()
        
        self.addComponent(self.characterComponent)
        self.addComponent(self.skNodeComponent)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
