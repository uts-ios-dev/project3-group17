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
        return [Walk(self), Idle(self)]
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);

        actionStateMachine.update(deltaTime: seconds);
    }
}
