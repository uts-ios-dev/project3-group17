//
//  BubbleComponent.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/2.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class BubbleComponent: GKComponent {
    
    public var node : SKSpriteNode { return (entity! as! BubbleEntity).node };
    
    public override init() {
        super.init();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTexture(_ altasName : String) {
        let animations = loadBubbleTextures(altasName);
        
        let scaleAnimations = SKAction.sequence([SKAction.scaleX(to: 0.9, y: 0.75, duration: 0.5),
                                                 SKAction.scaleX(to: 1.0, y: 1.0, duration: 0.5)]);
        
        self.node.texture = animations[0];
        
        self.node.run(SKAction.repeatForever(scaleAnimations));
    }
    
    private func loadBubbleTextures (_ altasName : String) -> [SKTexture] {
        
        let altas = SKTextureAtlas(named: altasName);
        var count = 0;
        var textures : [SKTexture] = [];
        
        for _ in altas.textureNames {
            textures.append(altas.textureNamed(String(count)));
            count += 1;
        }
        
        return textures;
    }
}
