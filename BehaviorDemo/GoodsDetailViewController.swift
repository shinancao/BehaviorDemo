//
//  GoodsDetailViewController.swift
//  BehaviorDemo
//
//  Created by Shinancao on 16/8/28.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import UIKit

class GoodsDetailViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let goods = Goods()
        goods.goodsPrice = 128.0
        goods.goodsImgPath = "goodsImg1"
        goods.goodsDesc = "非常好看非常大牌的一件毛呢夹克哦 料子的材质都是精挑细选的，所以要特别定制哦 衣服的做工非常精细，每一个边缘都细心剪裁夹克的版型也超赞，上身效果特别好 两个颜色都很好看哦，墨绿色实用百搭，橘色靓丽时尚 秋冬有了它会让你时尚度大增哦"
       
        let nc = NotificationCenter.default
        nc.post(name: .ShowGoodsInfoNotify, object: goods)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonTapped(_ sender: AnyObject) {
        self.navigationController?.pushViewController(GlobalViewController.sharedInstance, animated: true)
    }

}
