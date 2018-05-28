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
    
    var leftWalkingAnimation    : [SKTexture] = []
    var rightWalkingAnimation   : [SKTexture] = []
    var frontWalkingAnimation   : [SKTexture] = []
    var backWalkingAnimation    : [SKTexture] = []
    
    var leftIdleAnimation   : [SKTexture] = []
    var rightIdleAnimation  : [SKTexture] = []
    var frontIdleAnimation  : [SKTexture] = []
    var backIdleAnimation   : [SKTexture] = []
    
    var animations : [[SKTexture]] = []
    
    public func load (altasName : String) {
        
        let altas = SKTextureAtlas(named: altasName)
        
        for name in altas.textureNames {
            
            let texture = altas.textureNamed(name)
            let nameParts = name.split(separator: "_")
            
            let directionName = nameParts[0]
            let actionName = nameParts[1]
            
            if directionName == "front" {
                if actionName == "walking" {
                    self.frontWalkingAnimation.append(texture)
                }
                else if actionName == "idle" {
                    self.frontIdleAnimation.append(texture)
                }
            }
            
            switch directionName {
            case "front" :
                if actionName == "walking" {
                    self.frontIdleAnimation.append(texture)
                }
                else if actionName == "idle" {
                    self.frontWalkingAnimation.append(texture)
                }
                
                break;
            case "back" :
                if actionName == "walking" {
                    
                }
                
                
                
            default: break
                
            }
            
        }
    }
}
