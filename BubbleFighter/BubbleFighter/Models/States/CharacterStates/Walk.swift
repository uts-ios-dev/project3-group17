//
//  WalkLeft.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/1.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class Walk: CharacterState {
    
    private let walkSpeed : Double = Double(Configs.blockSize);
    
    public override func didEnter(from previousState: GKState?) {
        
        if (previousState == self && direction == lastDirection) {
            return;
        }
        
        super.didEnter(from: previousState)
        
        let animations = character.animationManager.get(0);
        
        character.node.texture = animations[0];
        
        character.node.run(SKAction.repeatForever(SKAction.animate(with: animations, timePerFrame: 0.1)));
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        
        if direction == Directions.left {
            character.node.position.x -= CGFloat(walkSpeed * seconds as Double);
        }
        else if direction == Directions.right {
            character.node.position.x += CGFloat(walkSpeed * seconds as Double);
        }
        else if direction == Directions.up {
            character.node.position.y += CGFloat(walkSpeed * seconds as Double);
        }
        else if direction == Directions.down {
            character.node.position.y -= CGFloat(walkSpeed * seconds as Double);
        }
    }
}
