//
//  AgentEntity.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/4.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit;
import GameplayKit;

public class AgentEntity: GKEntity {
    public var agent : GKAgent2D = GKAgent2D();
    
    public override init() {
        super.init();
        
        addComponent(agent);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
