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
    
    private var walkSpeed : Double { return character.walkSpeed };
    
    public override func didEnter(from previousState: GKState?) {
        
        if (previousState == self && direction == lastDirection) {
            return;
        }
        
        super.didEnter(from: previousState)
        
        let animations = character.animationManager.get(0);
        
        character.node.texture = animations[0];
        
        character.node.run(SKAction.repeatForever(SKAction.animate(with: animations, timePerFrame: 0.1)));
    }
    
    public override func willExit(to nextState: GKState) {
        //character.node.removeAllActions();
    }
}
