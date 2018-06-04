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

public class CharacterEntity : AgentEntity {
    
    public let characterComponent = CharacterComponent()
    public let skNodeComponent = GKSKNodeComponent(node: SKSpriteNode())
    
    public var node : SKSpriteNode {
        return self.skNodeComponent.node as! SKSpriteNode
    }
    
    override init() {
        super.init()
        
        self.addComponent(self.characterComponent)
        self.addComponent(self.skNodeComponent)
        
        self.node.size = CGSize(width: Configs.blockSize, height: Configs.characterHeight);
        self.node.anchorPoint = CGPoint(x: 0.5, y: 0.25)
    }
    
    public func configurePhysics() {
        self.node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Configs.blockSize, height: Configs.characterHalfHeight),
                                              center: CGPoint(x: 0, y: 0));
        self.node.physicsBody?.affectedByGravity = false
        self.node.physicsBody?.allowsRotation = false;
        
        self.node.physicsBody?.categoryBitMask = Configs.characterCategories[characterComponent.characterIndex];
        self.node.physicsBody?.collisionBitMask = Configs.nothingCollision;
        
        for i in 0 ... Configs.newBubbleCategories.count - 1{
            if i != characterComponent.characterIndex {
                self.node.physicsBody?.collisionBitMask |= Configs.newBubbleCategories[i];
            }
        }
        
        for bubbleCategory in Configs.bubbleCategories {
            self.node.physicsBody?.collisionBitMask |= bubbleCategory;
        }
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);
        
        agent.position = vector_float2(Float(self.node.position.x), Float(self.node.position.y));
        agent.speed = Float(characterComponent.walkSpeed);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
