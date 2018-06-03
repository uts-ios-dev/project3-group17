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
    
    private var character : CharacterComponent { return (entity! as! PlayerEntity).characterComponent };
    
    public override init() {
        super.init();
        
        let agent = (entity! as! AIEntity).agent;
        
        agent.delegate = self;
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func agentWillUpdate(_ agent: GKAgent) {
        
        let agent2D = agent as! GKAgent2D;
        
        agent2D.position.x = Float(character.node.position.x);
        agent2D.position.y = Float(character.node.position.y);
        
        
    }
    
    public func agentDidUpdate(_ agent: GKAgent) {
        
    }
    
    
}
