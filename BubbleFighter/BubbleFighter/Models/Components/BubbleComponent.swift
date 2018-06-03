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
        let animations = BubbleComponent.loadBubbleTextures(altasName);
        
        let scaleAnimations = SKAction.sequence([SKAction.scaleX(to: 0.9, y: 0.75, duration: 0.5),
                                                 SKAction.scaleX(to: 1.0, y: 1.0, duration: 0.5)]);
        
        self.node.texture = animations[0];
        
        self.node.run(SKAction.repeatForever(scaleAnimations));
    }
    
    public class func loadBubbleTextures (_ altasName : String) -> [SKTexture] {
        
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
    
        let explosionRange = CGFloat(self.energyLevel) * Configs.blockSize;
        
        let (upRangeLimit, downRangeLimit, rightRangeLimit, leftRangeLimit) = getExplosionLimits(range: explosionRange);
        
        print(upRangeLimit);
        print(downRangeLimit);
        print(leftRangeLimit);
        print(rightRangeLimit);
        
        self.hitCharacters(upRange: upRangeLimit,
                           downRange: downRangeLimit,
                           rightRange: rightRangeLimit,
                           leftRange: leftRangeLimit);
        
        self.hitWalls(upRange: upRangeLimit,
                      downRange: downRangeLimit,
                      rightRange: rightRangeLimit,
                      leftRange: leftRangeLimit);
        
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
    
    //Up Down Right Left
    private func getExplosionLimits (range : CGFloat) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var leftRangeLimit = range;
        var upRangeLimit = range;
        var downRangeLimit = range;
        var rightRangeLimit = range;
        
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
            
            guard let _ = child.entity?.component(ofType: HardWallComponent.self) else {
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
        
        return (upRangeLimit, downRangeLimit, rightRangeLimit, leftRangeLimit);
    }
    
    private func hitCharacters(upRange : CGFloat, downRange : CGFloat, rightRange : CGFloat, leftRange : CGFloat) {
        
        let characters = mainScene.characters;
        
        for character in characters {
            
            if (isHitWith(node: character.node, upRange: upRange,
                          downRange: downRange, rightRange: rightRange, leftRange: leftRange)) {
                character.hitByBubble();
            }
        }
    }
    
    private func hitWalls(upRange : CGFloat, downRange : CGFloat, rightRange : CGFloat, leftRange : CGFloat) {
        
        let walls = mainScene.softWalls;
        
        for wall in walls {
            if let node = wall.node {
                if (isHitWith(node: node, upRange: upRange,
                              downRange: downRange, rightRange: rightRange, leftRange: leftRange)) {
                    wall.hitByBubble();
                }
            }
        }
    }
    
    private func isHitWith(node : SKNode, upRange : CGFloat, downRange : CGFloat, rightRange : CGFloat, leftRange : CGFloat) -> Bool {
        
        let thresholdX = CGFloat(Configs.blockSize);
        let thresholdY = CGFloat(Configs.blockSize);

        let dx = node.position.x - self.node.position.x;
        let dy = node.position.y - self.node.position.y;
            
        if abs(dx) < thresholdX {
            if (dy > 0 && dy < upRange) || abs(dy) < downRange {
                return true;
            }
        }
        else if abs(dy) < thresholdY {
            if (dx > 0 && dx < rightRange) || abs(dx) < leftRange {
                return true;
            }
        }
        
        return false;
    }
}
