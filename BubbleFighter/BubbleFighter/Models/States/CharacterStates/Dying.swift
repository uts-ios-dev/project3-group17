//
//  Dying.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

public class Dying: CharacterState {

    public override func didEnter(from previousState: GKState?) {
        
        if (previousState == self) {
            return;
        }
        
        super.didEnter(from: previousState);
        
        let animations = character.animationManager.get(0);
        
        character.node.texture = animations[0];
    }

}
