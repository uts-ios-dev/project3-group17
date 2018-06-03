//
//  PlayerComponent.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/1.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class PlayerComponent: GKComponent {
    
    private var _lastBubbles : [BubbleEntity] = [];
    
    public override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds);
        
        let character = (entity! as! PlayerEntity).characterComponent;
        
        if character.actionStateMachine.currentState is Dying {
            return;
        }
        
        let input = InputManager.getInstance();
        
        if input.getKeyDown(InputKey.left) {
            character.direction = Directions.left;
            character.actionStateMachine.enter(Walk.self);
        }
        else if input.getKeyDown(InputKey.right) {
            character.direction = Directions.right;
            character.actionStateMachine.enter(Walk.self);
        }
        else if input.getKeyDown(InputKey.up) {
            character.direction = Directions.up;
            character.actionStateMachine.enter(Walk.self);
        }
        else if input.getKeyDown(InputKey.down) {
            character.direction = Directions.down;
            character.actionStateMachine.enter(Walk.self);
        }
        else {
            character.actionStateMachine.enter(Idle.self);
        }
        
        if input.getKeyClick(InputKey.attack) {
            character.placeBubble();
        }
    }
}
