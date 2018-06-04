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

public class BubbleEntity: AgentEntity {

    public let skNodeComponent = GKSKNodeComponent(node: SKSpriteNode());
    public var bubbleComponent : BubbleComponent = BubbleComponent();
    
    public var node : SKSpriteNode {
        return self.skNodeComponent.node as! SKSpriteNode
    }
    
    public override init() {
        super.init();
        
        addComponent(self.skNodeComponent);
        addComponent(self.bubbleComponent);
        
        self.node.zPosition = 5;
        self.node.size = CGSize(width: Configs.blockSize, height: Configs.blockSize);
        
        self.configurePhysics();
        
        self.agent.speed = 0;
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePhysics() {
        self.node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Configs.blockSize, height: Configs.characterHalfHeight),
                                                center: CGPoint(x: 0, y: 0))
        self.node.physicsBody?.allowsRotation = false;
        self.node.physicsBody?.affectedByGravity = false;
        self.node.physicsBody?.isDynamic = false;
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);
        
        agent.position = vector_float2(Float(self.node.position.x), Float(self.node.position.y));
    }
    
}
