//
//  AIComponent.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit;
import GameplayKit;
import SpriteKit;

public class AIComponent: GKComponent, GKAgentDelegate {
    
    private var character : CharacterComponent { return (entity! as! CharacterEntity).characterComponent };
    
    public override init() {
        super.init();
    }
    
    public override func didAddToEntity() {
        super.didAddToEntity();
        
        let entity = self.entity! as! CharacterEntity;
        
        let agent = entity.agent;
        
        agent.delegate = self;
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func agentWillUpdate(_ agent: GKAgent) {
        let agent2D = agent as! GKAgent2D;
        
        agent2D.position.x = Float(character.node.position.x);
        agent2D.position.y = Float(character.node.position.y);
        
        agent2D.speed = Float(character.walkSpeed);
        
    }
    
    public func agentDidUpdate(_ agent: GKAgent) {
        let agent2D = agent as! GKAgent2D;
        
        character.node.position.x = CGFloat(agent2D.position.x);
        character.node.position.y = CGFloat(agent2D.position.y);
        
        if (agent2D.rotation < 1.57) {
            character.direction = Directions.right;
        }
        else if (agent2D.rotation < 3.14) {
            character.direction = Directions.up;
        }
        else if (agent2D.rotation < 4.71) {
            character.direction = Directions.left;
        }
        else
        {
            character.direction = Directions.down;
        }
        
        print(agent2D.velocity);
        
        if agent2D.velocity.x != 0 || agent2D.velocity.y != 0 {
            character.actionStateMachine.enter(Walk.self);
        }
        else {
            character.actionStateMachine.enter(Idle.self);
        }
        
        
    }
    
    
}
