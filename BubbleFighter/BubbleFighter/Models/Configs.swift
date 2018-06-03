//
//  Config.swift
//  BubbleFighter
//
//  Created by HuangYe on 2018/6/2.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import Foundation

public class Configs {
    
    public static let blockSize : Int  = 32;
    
    public static let characterHeight : Int = 48;
    
    public static let characterHalfHeight : Int = 24;
    
    public static let characterQuarterHeight : Int = 12;

    //From 1 to 10
    public static let characterCategories : [UInt32] = [0x00000001, 0x00000002, 0x00000004, 0x00000008];
    
    //From 11-20
    public static let newBubbleCategories : [UInt32] = [0x00000400, 0x00000800, 0x00001000, 0x00002000];
    
    //From 21-30
    public static let bubbleCategories : [UInt32] = [0x00100000, 0x00200000, 0x00400000, 0x00800000];
    
}
