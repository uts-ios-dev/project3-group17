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
    private var aiPlayer : AIEntity!;
    
    private var obstacles : [GKObstacle]!;
    
    private var mainCamera : SKCameraNode = SKCameraNode();
    
    public var aiGeols : [GKGoal] = [];
    
    public var buffItems : [BuffComponent] = [];
    
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
    
    public var hardWalls : [HardWallComponent] {
        var results : [HardWallComponent] = [];
        
        for child in children {
            if let wall = child.entity?.component(ofType: HardWallComponent.self) {
                results.append(wall);
            }
        }
        
        return results;
    }

    override public func sceneDidLoad() {
        
        super.sceneDidLoad();
        
        self.camera = self.mainCamera;
    }
    
    
    public func mapDidLoad() {
        self.loadPlayers();
    }
    
    private func loadPlayers()
    {
        mainPlayer = PlayerEntity();
        mainPlayer.characterComponent.setTextureAltas("t");
        mainPlayer.characterComponent.characterIndex = 0;
        mainPlayer.node.position = CGPoint(x: -352, y: -64);
        mainPlayer.configurePhysics();
        
        addEntity(mainPlayer);
        
        self.loadObstacles();
        self.loadDefaultAiGoals();
        
        aiPlayer = AIEntity();
        aiPlayer.characterComponent.setTextureAltas("p");
        aiPlayer.characterComponent.characterIndex = 1;
        aiPlayer.node.position = CGPoint(x: -352, y: 64);
        aiPlayer.configurePhysics();
        aiPlayer.agent.behavior = GKBehavior(goals: self.aiGeols);
        
        addEntity(aiPlayer);
    }
    
    private func loadObstacles() {
        
        let hardWalls = self.hardWalls;
        var hardWallNodes : [SKNode] = [];
        
        for wall in hardWalls {
            if let node = wall.entity?.component(ofType: GKSKNodeComponent.self)?.node {
                hardWallNodes.append(node);
            }
        }
        
        self.obstacles = SKNode.obstacles(fromNodeBounds: hardWallNodes);
    }
    
    private func loadDefaultAiGoals() {
        aiGeols.append(GKGoal(toAvoid: self.obstacles, maxPredictionTime: 0.5));
        aiGeols.append(GKGoal(toSeekAgent: mainPlayer.agent));
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime);
        
        mainPlayer.node.zPosition = 10;
        mainCamera.zPosition = 15;
        mainCamera.position = mainPlayer.node.position;
    }
    
    public func addBuffItem (_ item : BuffComponent) {
        buffItems.append(item);
        addEntity(item.entity!);
    }
    
    public func removeBuffItem (_ item : BuffComponent) {
        if let index = buffItems.index(of: item) {
            buffItems.remove(at: index);
            removeEnitty(item.entity!);
        }
    }
    
    public func addGoal (_ goal : GKGoal)
    {
        aiGeols.append(goal);
    }
    
}
