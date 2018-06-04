//
//  DismissControllerSegue.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/4.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit

class DismissControllerSegue: UIStoryboardSegue {
    override func perform() {
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
