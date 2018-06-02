//
//  CharacterStates.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/5/31.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import GameplayKit;

public class CharacterState: GKState {
    
    public var character : CharacterComponent!;
    
    public var direction : Directions { return character.direction };
    
    convenience init(_ character : CharacterComponent) {
        self.init();
        
        self.character = character;
    }
    
}
