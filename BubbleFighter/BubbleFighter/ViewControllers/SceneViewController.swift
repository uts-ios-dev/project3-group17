//
//  SceneViewController.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/4.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class SceneViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func loadScene (sceneName : String) -> BaseScene? {
        if let scene = GKScene(fileNamed: sceneName) {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! BaseScene? {
                
                // Copy gameplay related content over to the scene
                
                for entity in scene.entities {
                    sceneNode.entities.append(entity)
                }
                
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    
                }
                
                sceneNode.mapDidLoad();
                
                return sceneNode;
            }
        }
        
        return nil;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
