//
//  GoodsDetailBehavior.swift
//  BehaviorDemo
//
//  Created by Shinancao on 16/8/28.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import UIKit

public class Goods: NSObject {
    public var goodsId: String?
    public var goodsDesc: String?
    public var goodsImgPath: String?
    public var goodsPrice: Float = 0
}

public extension Notification.Name {
    static let ShowGoodsInfoNotify = Notification.Name(rawValue:"ShowGoodsInfoNotify")
}

public class GoodsDetailBehavior: Behavior {

    @IBOutlet weak public var imageView: UIImageView!
    @IBOutlet weak public var priceLabel: UILabel!
    @IBOutlet weak public var descLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init frame")
        addNotification()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init coder")
    }
    
    deinit {
        print("GoodsDetailBehavior deinit...")
        removeNotification()
    }
    
    func setupWithGoods(_ goods: Goods) {
        imageView.image = UIImage(named: goods.goodsImgPath!)
        let priceStr = NSString(format: "%.2f ¥", goods.goodsPrice)
        priceLabel.text = priceStr as String
        descLabel.text = goods.goodsDesc
    }
    
    func addNotification() -> Void {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(catchNotification), name: .ShowGoodsInfoNotify, object: nil)
        
        nc.addObserver(forName: .ShowGoodsInfoNotify, object: nil, queue: nil, using: catchNotification)
    }
    
    func removeNotification() -> Void {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: .ShowGoodsInfoNotify, object: nil)
    }
    
    @objc func catchNotification(notification:Notification) -> Void {
        guard let goods = notification.object as? Goods else {
            return
        }
        
        setupWithGoods(goods)
    }
}
