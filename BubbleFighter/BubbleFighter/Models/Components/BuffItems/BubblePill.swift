//
//  BubblePill.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class BubblePill: BuffComponent {

    public override func start() {
        super.start();
        
        node.texture = SKTexture(image: #imageLiteral(resourceName: "BubblePill"));
    }
    
    public override func hitByCharacter(character: CharacterComponent) {
        
        character.useableBubbleLimit += 1;
        
        super.hitByCharacter(character: character);
    }
}
