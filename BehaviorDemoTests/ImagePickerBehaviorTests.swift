//
//  ImagePickerBehaviorTests.swift
//  BehaviorDemo
//
//  Created by Shinancao on 2016/12/10.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import XCTest
import BehaviorDemo

class ImagePickerBehaviorTests: XCTestCase {
    
    var behavior: ImagePickerBehavior!
    var viewController: UIViewController! //模拟与该behavior关联的UIViewController
    var button: UIButton! //模拟点击后弹出UIAlertController的button
    
    override func setUp() {
        super.setUp()
        
        viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        button = UIButton(type: .roundedRect)
        behavior = ImagePickerBehavior()
        behavior.owner = viewController
        button.addTarget(behavior, action: #selector(behavior.picImageFromButton), for: .touchUpInside)
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewController = nil
        behavior = nil
        button = nil
    }
    
    func testPresentUIAlertController() {
        button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(viewController.presentedViewController is UIAlertController, "UIAlertController isn't presented")
    }
    
    func testActionTitles() {
        button.sendActions(for: .touchUpInside)
        let alertController = viewController.presentedViewController as! UIAlertController
        
        XCTAssertTrue(alertController.actions.count == 3, "action count should be 3")
        let albumAction = alertController.actions[0]
        let cameraAction = alertController.actions[1]
        let cancelAction = alertController.actions[2]
        XCTAssertEqual(albumAction.title, "相册")
        XCTAssertEqual(cameraAction.title, "相机")
        XCTAssertEqual(cancelAction.title, "取消")
    }
    
    //http://swiftandpainless.com/correction-on-testing-uialertcontroller/
    //要改被测试的代码还是很不爽，也许一开始在写项目代码时就要考虑到可测试性
}
