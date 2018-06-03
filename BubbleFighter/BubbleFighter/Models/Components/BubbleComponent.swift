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
    public var mainScene : MainScene { return self.node.scene! as! MainScene };
    
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
    
        let explosionRange = CGFloat(self.energyLevel * Configs.blockSize);
        
        var leftRangeLimit = explosionRange;
        var upRangeLimit = explosionRange;
        var downRangeLimit = explosionRange;
        var rightRangeLimit = explosionRange;
        
        let left = node.position.x - node.anchorPoint.x * node.size.width;
        let right = node.position.x + (1 - node.anchorPoint.x) * node.size.width;
        
        let down = node.position.y - node.anchorPoint.y * node.size.height;
        let top = node.position.y + (1 - node.anchorPoint.y) * node.size.height;
        
        //Detect for direction
        let mainScene = self.mainScene;

        for child in mainScene.children {
            
            if child == self.node {
                continue;
            }
            
            if let spriteNode = child as? SKSpriteNode {
                
                let dx = child.position.x - self.node.position.x;
                let dy = child.position.y - self.node.position.y;
                
                let childLeft = spriteNode.position.x - spriteNode.anchorPoint.x * spriteNode.size.width;
                let childRight = spriteNode.position.x + (1 - spriteNode.anchorPoint.x) * spriteNode.size.width;
                
                let childDown = spriteNode.position.y - spriteNode.anchorPoint.y * spriteNode.size.height;
                let childTop = spriteNode.position.y + (1 - spriteNode.anchorPoint.y) * spriteNode.size.height;
                
                if  (childLeft  <= left && childRight   >= right) ||
                    (childLeft  >= left && childLeft    <= right) ||
                    (childRight >= left && childRight   <= right) ||
                    (childLeft  >= left && childRight   <= right)
                {
                    let upRange = abs(childDown - top);
                    let downRange = abs(childTop - down);
                    
                    if (dy > 0 && upRangeLimit > upRange) {
                        upRangeLimit = upRange;
                    }
                    else if (downRangeLimit > downRange) {
                        downRangeLimit = downRange;
                    }
                }
                else if (childDown  <= down && childTop     >= top) ||
                        (childDown  >= down && childDown    <= top) ||
                        (childTop   >= down && childTop     <= top) ||
                        (childDown  >= down && childTop     <= top)
                {
                    let leftRange = abs(childRight - left);
                    let rightRange = abs(childLeft - right);
                    
                    if (dx > 0 && rightRangeLimit > rightRange) {
                        rightRangeLimit = rightRange;
                    }
                    else if (leftRangeLimit > leftRange) {
                        leftRangeLimit = leftRange;
                    }
                }
            }
        }
        
        print(upRangeLimit);
        print(downRangeLimit);
        print(leftRangeLimit);
        print(rightRangeLimit);
        
        //Show particles
        if let particle = SKEmitterNode(fileNamed: Configs.bubbleExplosionFileName) {
            particle.position = self.node.position;
            particle.zPosition = 5;
            particle.particleLifetime = rightRangeLimit / particle.particleSpeed;
            
            let action = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.removeFromParent()]);
            
            let particleLeft = particle.copy() as! SKEmitterNode;
            particleLeft.emissionAngle = CGFloat.pi;
            particleLeft.particleLifetime = leftRangeLimit / particle.particleSpeed;
            
            let particleTop = particle.copy() as! SKEmitterNode;
            particleTop.emissionAngle = 0.5 * CGFloat.pi;
            particleTop.particleLifetime = upRangeLimit / particle.particleSpeed;
            
            let particleDown = particle.copy() as! SKEmitterNode;
            particleDown.emissionAngle = 1.5 * CGFloat.pi;
            particleDown.particleLifetime = downRangeLimit / particle.particleSpeed;
            
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
