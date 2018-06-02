//
//  BubbleEntity.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/2.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class BubbleEntity: GKEntity {

    public let skNodeComponent = GKSKNodeComponent(node: SKSpriteNode());
    public var bubbleComponent : BubbleComponent!;
    
    public var node : SKSpriteNode {
        return self.skNodeComponent.node as! SKSpriteNode
    }
    
    public init(_ altasName : String) {
        super.init();
        
        self.bubbleComponent = BubbleComponent();
        
        addComponent(self.skNodeComponent);
        addComponent(self.bubbleComponent);
        
        bubbleComponent.setTexture(altasName);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
