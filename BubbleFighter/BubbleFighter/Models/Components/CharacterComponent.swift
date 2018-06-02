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
    
    private var _direction = Directions.down
    
    public var animationManager : CharacterAnimationManager { return self._animationManager };
    
    public var direction : Directions { return self._direction }
    
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
        
        actionStateMachine.update(deltaTime: seconds);
    }
}
