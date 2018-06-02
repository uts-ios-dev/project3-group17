//
//  GameViewController.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/5/27.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class GameViewController: UIViewController {

    private var inputs : InputManager = InputManager.getInstance();
    
    @IBOutlet weak var upButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var downButton: UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var attackButton: UIButton!
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        self.loadScene(sceneName: "TestScene")
    }
    
    private func loadScene (sceneName : String)
    {
        if let scene = GKScene(fileNamed: sceneName) {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MainScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
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
            }
        }
    }

    override public var shouldAutorotate: Bool {
        return true
    }

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .all
        } else {
            return .all
        }
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func onButtonDown(_ sender: UIButton) {
        switch sender {
        case upButton       : inputs.setKeyState(InputKey.up,       state: InputStates.Down);   break;
        case rightButton    : inputs.setKeyState(InputKey.right,    state: InputStates.Down);   break;
        case downButton     : inputs.setKeyState(InputKey.down,     state: InputStates.Down);   break;
        case leftButton     : inputs.setKeyState(InputKey.left,     state: InputStates.Down);   break;
        case attackButton   : inputs.setKeyState(InputKey.attack,   state: InputStates.Down);   break;
        default: fatalError("Button not found");
        }
    }
    
    
    @IBAction func onButtonUpInside(_ sender: UIButton) {
        switch sender {
        case upButton       : inputs.setKeyState(InputKey.up,       state: InputStates.Up);     break;
        case rightButton    : inputs.setKeyState(InputKey.right,    state: InputStates.Up);     break;
        case downButton     : inputs.setKeyState(InputKey.down,     state: InputStates.Up);     break;
        case leftButton     : inputs.setKeyState(InputKey.left,     state: InputStates.Up);     break;
        case attackButton   : inputs.setKeyState(InputKey.attack,   state: InputStates.Up);     break;
        default: fatalError("Button not found");
        }
    }
    
    @IBAction func onButtonUpOutside(_ sender: UIButton) {
        switch sender {
        case upButton       : inputs.setKeyState(InputKey.up,       state: InputStates.Up);     break;
        case rightButton    : inputs.setKeyState(InputKey.right,    state: InputStates.Up);     break;
        case downButton     : inputs.setKeyState(InputKey.down,     state: InputStates.Up);     break;
        case leftButton     : inputs.setKeyState(InputKey.left,     state: InputStates.Up);     break;
        case attackButton   : inputs.setKeyState(InputKey.attack,   state: InputStates.None);   break;
        default: fatalError("Button not found");
        }
    }
    
    
}
