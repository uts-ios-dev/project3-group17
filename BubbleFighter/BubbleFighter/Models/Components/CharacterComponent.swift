//
//  Character.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/5/28.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class CharacterComponent : GKComponent {
    
    let animationManager : CharacterAnimationManager = CharacterAnimationManager()
    
    public func setTextureAltas(_ altasName : String) {
        self.animationManager.load(altasName)
    }
}
