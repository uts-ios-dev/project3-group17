//
//  Dead.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import GameplayKit;
import SpriteKit;

public class Dead: CharacterState {

    public override func didEnter(from previousState: GKState?) {
        
        if (previousState == self) {
            return;
        }
        
        super.didEnter(from: previousState);
        
        character.node.removeAllActions();
        
        character.node.physicsBody?.categoryBitMask = Configs.nothingCollision;
        character.node.physicsBody?.collisionBitMask = Configs.nothingCollision;
        
        character.direction = Directions.up;
        let animations = character.animationManager.get(1);
        
        character.node.texture = animations[0];
        
        character.node.run(SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi / 2, duration: 0.5),
                                              SKAction.fadeAlpha(to: 0, duration: 5)]));
        
    }
    
}
