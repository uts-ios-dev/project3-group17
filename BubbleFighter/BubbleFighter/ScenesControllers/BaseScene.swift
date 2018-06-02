//
//  BaseScene.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/1.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class BaseScene: SKScene {

    public var entities = [GKEntity]()
    public var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    override public func sceneDidLoad() {
        
        self.lastUpdateTime = 0
    }
    
    public func addEntity(_ entity : GKEntity)
    {
        entities.append(entity)
        
        if let node = entity.component(ofType: GKSKNodeComponent.self)?.node {
            self.addChild(node)
        }
    }
    
    public func removeEnitty(_ entity: GKEntity)
    {
        if let node = entity.component(ofType: GKSKNodeComponent.self)?.node {
            node.removeFromParent()
        }
        
        if let index = entities.index(of: entity)
        {
            entities.remove(at: index)
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
            
            for component in entity.components {
                component.update(deltaTime: dt)
            }
        }
        
        self.lastUpdateTime = currentTime
    }
}
