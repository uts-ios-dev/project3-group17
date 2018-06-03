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
    public var node : SKNode? {
        return entity?.component(ofType: GKSKNodeComponent.self)?.node;
    }
    
    public func hitByBubble() {
        
        let position = node!.position;
        
        let scene = node!.scene! as! MainScene;
        
        scene.removeEnitty(entity!);
        
        
    }
}
