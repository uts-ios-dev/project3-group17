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
    
    private var _animationManager : CharacterAnimationManager!;
    private var actionStateMachine : GKStateMachine!
    
    private var _direction = Directions.down {
        willSet {
            self._lastDirection = self._direction;
        }
    }
    private var _lastDirection = Directions.up;
    
    public var animationManager : CharacterAnimationManager { return self._animationManager };
    
    public var direction : Directions { return self._direction };
    
    public var lastDirection : Directions { return self._lastDirection };
    
    public var node : SKSpriteNode { return (entity! as! CharacterEntity).node };
    
    public override init() {
        super.init()
        
        self._animationManager = CharacterAnimationManager(self);
        self.actionStateMachine = GKStateMachine(states: loadActionStateMachine());
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
        return [Walk(self), Idle(self)]
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);
        
        let input = InputManager.getInstance();
        
        if input.getKeyDown(InputKey.left) {
            self._direction = Directions.left;
            self.actionStateMachine.enter(Walk.self);
        }
        else if input.getKeyDown(InputKey.right) {
            self._direction = Directions.right;
            self.actionStateMachine.enter(Walk.self);
        }
        else if input.getKeyDown(InputKey.up) {
            self._direction = Directions.up;
            self.actionStateMachine.enter(Walk.self);
        }
        else if input.getKeyDown(InputKey.down) {
            self._direction = Directions.down;
            self.actionStateMachine.enter(Walk.self);
        }
        else {
            self.actionStateMachine.enter(Idle.self);
        }
        
        
        actionStateMachine.update(deltaTime: seconds);
    }
}
