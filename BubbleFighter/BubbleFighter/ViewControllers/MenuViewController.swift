//
//  MenuViewController.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/4.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit

class MenuViewController: SceneViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadScene(sceneName: "MainMenuScene");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
