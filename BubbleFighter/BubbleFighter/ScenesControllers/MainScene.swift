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
        mainPlayer.node.size = CGSize(width: Double(Configs.blockSize), height:Double(Configs.blockSize) * 1.5);
        mainPlayer.node.position = CGPoint(x: -50, y: 0);
        mainPlayer.node.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        addEntity(mainPlayer);
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime);
        
        mainPlayer.node.zPosition = 10;
        mainCamera.zPosition = 15;
        mainCamera.position = mainPlayer.node.position;
        
        
    }
    
}
