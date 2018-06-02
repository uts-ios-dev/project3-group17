//
//  Idle.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/1.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class Idle: CharacterState {
    
    public override func didEnter(from previousState: GKState?) {
        
        if (previousState == self) {
            return;
        }
        
        super.didEnter(from: previousState)
        
        let animations = character.animationManager.get(1);
        
        character.node.texture = animations[0];
        
        character.node.run(SKAction.repeatForever(SKAction.animate(with: animations, timePerFrame: 0.1)));
    }

    public override func update(deltaTime seconds: TimeInterval) {
        
        
    }
}
