//
//  GoodsDetailBehaviorTests.swift
//  BehaviorDemo
//
//  Created by Shinancao on 2016/12/10.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import XCTest
import BehaviorDemo

class GoodsDetailBehaviorTests: XCTestCase {
    
    var behavior: GoodsDetailBehavior!
    var imageView: UIImageView!
    var priceLbl: UILabel!
    var descLbl: UILabel!
    
    override func setUp() {
        super.setUp()
        
        behavior = GoodsDetailBehavior()
        
        imageView = UIImageView()
        priceLbl = UILabel()
        descLbl = UILabel()
        
        behavior.imageView = imageView
        behavior.priceLabel = priceLbl
        behavior.descLabel = descLbl
    }
    
    override func tearDown() {
        super.tearDown()
    
    }
    
    func testSetGoodsInfoWhenReceiveNotification() {
        //given
        let goods = Goods()
        goods.goodsId = "1000"
        goods.goodsDesc = "针织衫 杨幂同款"
        goods.goodsImgPath = "goodsImg1"  //此处的图片要是在主工程里有的
        goods.goodsPrice = 200.0
        
        //when
        let nc = NotificationCenter.default
        nc.post(name: .ShowGoodsInfoNotify, object: goods)
        
        //then
        XCTAssertNotNil(behavior.imageView.image, "图片没有获取到")
        XCTAssertNotNil(behavior.priceLabel.text, "价格没有获取到")
        XCTAssertNotNil(behavior.descLabel.text, "描述没有获取到")
    }
}
