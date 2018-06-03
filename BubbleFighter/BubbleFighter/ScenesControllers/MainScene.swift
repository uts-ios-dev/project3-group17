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
    
    //Improve the performance use a cached in future
    public var characters : [CharacterComponent] {
        var results : [CharacterComponent] = [];
        
        for child in children {
            if let character = child.entity?.component(ofType: CharacterComponent.self) {
                results.append(character);
            }
        }
        
        return results;
    }
    
    public var softWalls : [SoftWallComponent] {
        var results : [SoftWallComponent] = [];
        
        for child in children {
            if let wall = child.entity?.component(ofType: SoftWallComponent.self) {
                results.append(wall);
            }
        }
        
        return results;
    }

    override public func sceneDidLoad() {
        
        super.sceneDidLoad();
        
        self.camera = self.mainCamera;
        
        self.loadPlayers();
    }
    
    private func loadPlayers()
    {
        mainPlayer = PlayerEntity();
        mainPlayer.characterComponent.setTextureAltas("t");
        mainPlayer.node.position = CGPoint(x: -50, y: 0);
        
        addEntity(mainPlayer);
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime);
        
        mainPlayer.node.zPosition = 10;
        mainCamera.zPosition = 15;
        mainCamera.position = mainPlayer.node.position;
        
        
    }
    
}
