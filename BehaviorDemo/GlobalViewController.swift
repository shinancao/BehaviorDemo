//
//  GlobalViewController.swift
//  BehaviorDemo
//
//  Created by Shinancao on 2016/10/30.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import UIKit

class GlobalViewController: UIViewController {

    static let sharedInstance = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GlobalViewController")
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
