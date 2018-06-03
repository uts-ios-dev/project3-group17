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
    
    public var timeCountDown : Double  = 5;
    
    public var energyLevel = 1;
    
    public var explodedCallback : ((BubbleEntity) -> ())?;
    
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
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);
        
        timeCountDown -= seconds;
        
        if timeCountDown <= 0 {
            self.explosion();
        }
    }
    
    public func explosion() {
        //Show particles
        if let particle = SKEmitterNode(fileNamed: Configs.bubbleExplosionFileName) {
            particle.position = CGPoint(x: self.node.position.x, y: self.node.position.y + CGFloat(Configs.characterQuarterHeight));
            particle.zPosition = 5;
            particle.particleLifetime = CGFloat(self.energyLevel * Configs.blockSize) / particle.particleSpeed;
            
            let action = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.removeFromParent()]);
            
            let particleLeft = particle.copy() as! SKEmitterNode;
            particleLeft.emissionAngle = CGFloat.pi;
            
            let particleTop = particle.copy() as! SKEmitterNode;
            particleTop.emissionAngle = 1.5 * CGFloat.pi;
            
            let particleDown = particle.copy() as! SKEmitterNode;
            particleDown.emissionAngle = 0.5 * CGFloat.pi;
            
            node.parent?.addChild(particle);
            node.parent?.addChild(particleLeft);
            node.parent?.addChild(particleTop);
            node.parent?.addChild(particleDown);
            
            particle.run(action);
            particleLeft.run(action);
            particleTop.run(action);
            particleDown.run(action);
        }
        
        self.explodedCallback?(entity! as! BubbleEntity);
    }
}
