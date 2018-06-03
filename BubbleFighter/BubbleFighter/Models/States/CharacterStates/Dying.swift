//
//  Dying.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

public class Dying: CharacterState {

    var dyingCountDown : Double = 10;
    let dyingCountDownLabel : SKLabelNode = SKLabelNode(text: "5");
    
    var bubbleNode : SKSpriteNode!;
    
    public override func didEnter(from previousState: GKState?) {
        
        if (previousState == self) {
            return;
        }
        
        super.didEnter(from: previousState);
        
        character.direction = Directions.down
        
        let animations = character.animationManager.get(1);
        
        character.node.removeAllActions();
        
        character.node.run(SKAction.repeatForever(SKAction.animate(with: [animations[0]], timePerFrame: 1)));
        
        let bubbles = BubbleComponent.loadBubbleTextures("Bubble");
        self.bubbleNode = SKSpriteNode(texture: bubbles[0]);
        
        self.bubbleNode.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        self.bubbleNode.position = CGPoint(x: 0, y: Configs.characterQuarterHeight);
        self.bubbleNode.zPosition = character.node.zPosition + 1;
        
        let scaleAnimations = SKAction.sequence([SKAction.scaleX(to: 2, y: 2, duration: 0.5),
                                                 SKAction.scaleX(to: 2.3, y: 2.1, duration: 0.5)]);
        
        self.bubbleNode.run(SKAction.repeatForever(scaleAnimations));
        character.node.addChild(self.bubbleNode);
        
        
        character.node.addChild(dyingCountDownLabel);
        dyingCountDownLabel.position = CGPoint(x: 0, y: Configs.blockSize * 2);
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);
        
        dyingCountDown -= seconds;
        
        if (dyingCountDown <= 0)
        {
            character.killed();
            character.node.removeAllChildren();
            
            return;
        }
        
        dyingCountDownLabel.text = String(Int(round(dyingCountDown)));
    }

}
