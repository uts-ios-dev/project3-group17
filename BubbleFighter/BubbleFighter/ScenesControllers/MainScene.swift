//
//  MainScene.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/5/28.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import SpriteKit
import GameplayKit

public class MainScene: BaseScene {

    private var moveUpButton : GameControlEntity!
    private var moveDownButton : GameControlEntity!
    private var moveLeftButton : GameControlEntity!
    private var moveRightButton : GameControlEntity!
    
    override public func sceneDidLoad() {
        
        super.sceneDidLoad()
        
        self.loadGameControls()
    }
    
    private func loadGameControls()
    {
        moveUpButton    = GameControlEntity(labelText: "U")
        moveDownButton  = GameControlEntity(labelText: "D")
        moveLeftButton  = GameControlEntity(labelText: "L")
        moveRightButton = GameControlEntity(labelText: "R")
        
        moveUpButton.node.position = CGPoint(x: 30, y: 50)
        moveDownButton.node.position = CGPoint(x: 30, y: 10)
        moveLeftButton.node.position = CGPoint(x: 10, y: 30)
        moveRightButton.node.position = CGPoint(x: 50, y: 30)
        
        addEntity(moveUpButton)
        addEntity(moveDownButton)
        addEntity(moveLeftButton)
        addEntity(moveRightButton)
    }
    
    private func loadPlayers()
    {
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
