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
    public static var animationsDict : [String : [SKTexture]] = [:];
    
    public override init() {
        super.init();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTexture(_ altasName : String) {
        let animations = loadAnimation(altasName);
        //node.texture = animations[0];
        self.node.run(SKAction.repeatForever(SKAction.animate(with: animations, timePerFrame: 0.1)));
    }
    
    private func loadAnimation(_ altasName : String) -> [SKTexture] {
        if BubbleComponent.animationsDict[altasName] == nil {
            let textures = loadBubbleTextures(altasName);
            BubbleComponent.animationsDict[altasName] = getAnimation(textures);
        }
        
        return BubbleComponent.animationsDict[altasName]!;
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
    
    private func getAnimation(_ textures : [SKTexture]) -> [SKTexture] {
        let count = textures.count;
        
        var results : [SKTexture] = []
        
        for texture in textures {
            results.append(texture);
        }
        
        for i in (1...count - 2).reversed() {
            results.append(textures[i]);
        }
        
        return results;
    }
}
