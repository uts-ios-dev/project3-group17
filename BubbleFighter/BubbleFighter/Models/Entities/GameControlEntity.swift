//
//  GameControlEntity.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/1.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class GameControlEntity : GKEntity
{
    public var skNodeComponent = GKSKNodeComponent(node: SKSpriteNode())
    
    public var node : SKNode { return skNodeComponent.node }
    
    public override init() {
        super.init()
        
        addComponent(skNodeComponent)
    }
    
    convenience public init(labelText : String) {
        self.init()
        
        self.skNodeComponent.node = SKLabelNode(text: labelText)
        
        //self.skNodeComponent = GKSKNodeComponent(node: SKLabelNode(text: labelText))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
