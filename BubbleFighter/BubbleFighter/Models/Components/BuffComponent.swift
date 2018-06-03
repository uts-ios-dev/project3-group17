//
//  BuffComponent.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

public class BuffComponent: GKComponent {
    public var node : SKSpriteNode {
        return entity!.component(ofType: GKSKNodeComponent.self)!.node as! SKSpriteNode;
    }
    
    public override init() {
        super.init();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func start() {
        entity!.addComponent(GKSKNodeComponent(node: SKSpriteNode()));
        
        node.size = CGSize(width: Configs.blockSize, height: Configs.blockSize);
    }
    
    public func setTexture(name : String) {
        node.texture = SKTexture(imageNamed: name);
    }
    
    public func hitByBubble() {
        let scene = node.scene! as! MainScene;
        scene.removeBuffItem(self);
    }
    
    public func hitByCharacter(character : CharacterComponent) {
        let scene = node.scene! as! MainScene;
        scene.removeBuffItem(self);
    }
}
