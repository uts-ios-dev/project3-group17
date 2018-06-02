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
    private var mainCamera : SKCameraNode = SKCameraNode();

    override public func sceneDidLoad() {
        
        super.sceneDidLoad();
        
        self.camera = self.mainCamera;
        
        self.loadPlayers();
    }
    
    private func loadPlayers()
    {
        mainPlayer = PlayerEntity();
        mainPlayer.characterComponent.setTextureAltas("t");
        mainPlayer.node.size = CGSize(width: 24, height: 32);
        mainPlayer.node.position = CGPoint(x: 50, y: 0);
        
        addEntity(mainPlayer);
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime);
        
        mainPlayer.node.zPosition = 10;
        mainCamera.zPosition = 15;
        mainCamera.position = mainPlayer.node.position;
        
        let inputs = InputManager.getInstance();
        
        if inputs.getKeyClick(InputKey.attack) {
            let bubble = BubbleEntity("Bubble");
            bubble.node.zPosition = 5;
            bubble.node.position = mainPlayer.node.position;
            bubble.node.size = CGSize(width: mainPlayer.node.size.width, height: mainPlayer.node.size.width);
            addEntity(bubble);
        }
    }
    
}
