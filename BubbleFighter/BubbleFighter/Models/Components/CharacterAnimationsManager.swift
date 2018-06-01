//
//  CharacterAnimationsManager.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/5/28.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation
import SpriteKit

public class CharacterAnimationManager {

    //2 * 8 array
    var animations : [[[SKTexture]]] = []
    
    let partOrder0 = ["up", "down", "left", "right"]
    let partOrder1 = ["walking", "idle"]
    
    public func load (_ altasName : String) {
        
        animations = Array.init(repeating: [[SKTexture]](), count: partOrder0.count)
        
        for i in 0...animations.count - 1 {
            animations[i] = Array.init(repeating: [SKTexture](), count: partOrder1.count)
        }
        
        let altas = SKTextureAtlas(named: altasName)
        
        for name in altas.textureNames {
            
            let texture = altas.textureNamed(name)
            let nameParts = name.components(separatedBy: "_")
            
            let partIndex0 = partOrder0.index(of: nameParts[0])
            let partindex1 = partOrder1.index(of: nameParts[1])
            
            animations[partIndex0!][partindex1!].append(texture);
        }
    }
}
