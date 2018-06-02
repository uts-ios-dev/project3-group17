//
//  InputKey.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/2.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation

public class InputKey {
    public static let left  = "left";
    public static let right = "right";
    public static let up    = "up";
    public static let down  = "down";
    
    public static let attack = "attack";
    
    private var _lastState : InputStates = InputStates.None;
    
    public var lastState : InputStates { return self._lastState }
    
    public var state : InputStates = InputStates.Up {
        willSet {
            self._lastState = self.state;
        }
    };
    
    public var name : String = "null";
    
    public init() { }
    
    convenience public init(_ name : String) {
        self.init()
        self.name = name
    }
}
