//
//  InputsManager.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/2.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation

public class InputManager {

    private var _inputs : [InputKey] = [];
    
    public init() {
        
        self.loadDefaultInputs();
    }
    
    public func loadDefaultInputs() {
        addRange(InputKey.left,
                 InputKey.right,
                 InputKey.up,
                 InputKey.down,
                 InputKey.attack);
    }
    
    public func add (_ name : String) {
        self._inputs.append(InputKey(name));
    }
    
    public func addRange (_ names: String...) {
        for name in names {
            add(name);
        }
    }
    
    public func getKey (_ keyName : String) -> InputKey? {
        for key in self._inputs {
            if key.name == keyName {
                return key;
            }
        }
        
        return nil;
    }
    
    public func getKeyDown (_ keyName : String) -> Bool {
        if let key = getKey(keyName) {
            return key.state == InputStates.Down;
        }
        
        return false;
    }
    
    public func getKeyUp (_ keyName : String) -> Bool {
        if let key = getKey(keyName) {
            return key.state == InputStates.Up;
        }
        
        return false;
    }
    
    public func getKeyClick(_ keyName : String) -> Bool {
        if let key = self.getKey(keyName) {
            if key.state == InputStates.Up && key.lastState == InputStates.Down {
                key.state = InputStates.None;
                
                return true;
            }
        }
        
        return false;
    }
    
}
