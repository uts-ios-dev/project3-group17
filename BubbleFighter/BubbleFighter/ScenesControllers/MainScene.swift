//
//  MainScene.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/5/28.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import SpriteKit
import GameplayKit

public class MainScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var players : [CharacterComponent] = []
    
    private var lastUpdateTime : TimeInterval = 0
    
    override public func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
        self.loadPlayers()
        
    }
    
    private func loadGameControls()
    {
        
    }
    
    private func loadPlayers()
    {
        
    }
    
    public func addPlayer (player : CharacterComponent)
    {
        
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

        let dt = currentTime - self.lastUpdateTime
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
}
