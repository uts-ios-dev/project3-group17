//
//  MainScene.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/5/28.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class MainScene: BaseScene {
    
    private var mainPlayer : PlayerEntity!;

    override public func sceneDidLoad() {
        
        super.sceneDidLoad();
        
        self.loadPlayers();
        
    }
    
    private func loadPlayers()
    {
        mainPlayer = PlayerEntity();
        mainPlayer.characterComponent.setTextureAltas("t");
        mainPlayer.node.position = CGPoint(x: 0, y: 0);
        
        addEntity(mainPlayer);
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime);
    }
    
}
