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
    
    private let _animationManager : CharacterAnimationManager = CharacterAnimationManager()
    private var actionStateMachine : GKStateMachine!
    
    private var _direction = Directions.down
    
    public var direction : Directions { return self._direction }
    
    public override init() {
        super.init()
        
        
        
        self.actionStateMachine = GKStateMachine();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTextureAltas(_ altasName : String) {
        self._animationManager.load(altasName)
    }
    
    public func loadActionStateMachine() -> [CharacterState]
    {
        return [Walk(self), Idle(self)]
    }
}
