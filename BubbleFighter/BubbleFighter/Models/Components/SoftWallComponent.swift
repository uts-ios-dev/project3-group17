//
//  SoftWallComponent.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/3.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class SoftWallComponent: GKComponent {
    
    public static let rand = GKRandomDistribution(lowestValue: 0, highestValue: 10);
    
    public var node : SKNode? {
        return entity?.component(ofType: GKSKNodeComponent.self)?.node;
    }
    
    public func hitByBubble() {
        
        let position = node!.position;
        
        let scene = node!.scene! as! MainScene;
        
        scene.removeEnitty(entity!);
        
        let items : [Float : BuffComponent] = [0.3 : EnergyPill(), 0.4 : BubblePill()];
        
        if let item = getResult(items) {
            let buffEntity = GKEntity();
            let agent : GKAgent2D = GKAgent2D();
            
            buffEntity.addComponent(agent);
            agent.position = vector_float2(Float(position.x), Float(position.y));
            agent.speed = 0;
            
            buffEntity.addComponent(item);
            item.start();
            
            buffEntity.component(ofType: GKSKNodeComponent.self)?.node.position = position;
            
            scene.addBuffItem(item);
        }
    }
    
    public func getResult (_ items : [Float : BuffComponent]) -> BuffComponent? {
        
        let keys = items.keys;
        
        var counter : Float = 0;
        
        let randResult = Float(SoftWallComponent.rand.nextInt()) / 10;
        
        print(randResult);
        
        for key in keys {
            counter += key;
            
            if counter >= randResult {
                return items[key];
            }
        }
        
        return nil;
    }
}
