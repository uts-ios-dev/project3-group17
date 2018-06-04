//
//  ResultViewController.swift
//  BubbleFighter
//
//  Created by Edward Huang on 2018/6/4.
//  Copyright © 2018年 HuangYe. All rights reserved.
//

import UIKit

public class ResultViewController: UIViewController {

    public var win : Bool = false;
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if win {
            resultLabel.text = "You Win ! :)"
        }
        else {
            resultLabel.text = "You lose T_T"
        }
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickedBackButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil);
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
