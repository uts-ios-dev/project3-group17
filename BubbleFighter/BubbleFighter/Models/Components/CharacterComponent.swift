//
//  Character.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/5/28.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class CharacterComponent : GKComponent {
    
    public var characterIndex : Int = 0;
    public var energyLevel : Int = 1;
    public var useableBubbleLimit : Int = 1;
    
    private var _lastBubbles : [BubbleEntity] = [];
    
    private var _animationManager : CharacterAnimationManager!;
    private var _actionStateMachine : GKStateMachine!
    
    private var _lastDirection = Directions.up;
    public var direction = Directions.down {
        willSet {
            self._lastDirection = self.direction;
        }
    }
    
    public var actionStateMachine : GKStateMachine { return self._actionStateMachine };
    
    public var animationManager : CharacterAnimationManager { return self._animationManager };
    
    public var lastDirection : Directions { return self._lastDirection };
    
    public var mainScene : MainScene { return self.node.scene! as! MainScene };
    
    public var node : SKSpriteNode { return (entity! as! CharacterEntity).node };
    
    public override init() {
        super.init()
        
        self._animationManager = CharacterAnimationManager(self);
        self._actionStateMachine = GKStateMachine(states: loadActionStateMachine());
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTextureAltas(_ altasName : String) {
        self._animationManager.load(altasName)
        self.actionStateMachine.enter(Idle.self);
    }
    
    public func loadActionStateMachine() -> [CharacterState]
    {
        return [Walk(self), Idle(self), Dying(self), Dead(self)];
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);

        actionStateMachine.update(deltaTime: seconds);
        
        self.configureLastBubblesCollision();
    }
    
    public func placeBubble () {
        
        if (useableBubbleLimit <= 0) {
            return;
        }
        
        useableBubbleLimit -= 1;
        
        let bubble = BubbleEntity();
        
        bubble.node.position = CGPoint(x: round(self.node.position.x), y: round(self.node.position.y));
        bubble.bubbleComponent.setTexture("Bubble");
        bubble.bubbleComponent.energyLevel = self.energyLevel;
        bubble.bubbleComponent.explodedCallback = self.onBubbleExploded;
        
        self.configureNewBubbleCollision(bubble);
        
        self.mainScene.addEntity(bubble);
        self._lastBubbles.append(bubble);
    }
    
    private func configureNewBubbleCollision(_ bubble : BubbleEntity) {
        bubble.node.physicsBody?.categoryBitMask = Configs.newBubbleCategories[characterIndex];
        bubble.node.physicsBody?.collisionBitMask = 0x00000000;
        
        for i in 0...Configs.characterCategories.count - 1 {
            
            if i != characterIndex {
                bubble.node.physicsBody?.collisionBitMask |= Configs.characterCategories[i];
            }
        }
    }
    
    private func configureLastBubblesCollision() {
        let characterPosition = self.node.position;
        let threshold1 = CGFloat(Configs.blockSize) * 0.5 + 5;
        let threshold2 = CGFloat(Configs.blockSize) + 1;
        
        for (i, _) in self._lastBubbles.enumerated().reversed() {
            let bubble = _lastBubbles[i];
            let position = bubble.node.position;
            
            if abs(position.x - characterPosition.x) > threshold1 ||
                abs(position.y - characterPosition.y) > threshold2 {
                
                bubble.node.physicsBody?.categoryBitMask = Configs.bubbleCategories[characterIndex];
                bubble.node.physicsBody?.collisionBitMask |= Configs.characterCategories[characterIndex];
                
                self._lastBubbles.remove(at: i);
            }
        }
    }
    
    private func onBubbleExploded (bubble : BubbleEntity) {
        
        useableBubbleLimit += 1;
        mainScene.removeEnitty(bubble);
    }
    
    public func hitByBubble() {
        actionStateMachine.enter(Dying.self);
    }
    
    public func killed() {
        actionStateMachine.enter(Dead.self);
    }
    
    
}
