//
//  CheckCodeBehaviorTests.swift
//  BehaviorDemo
//
//  Created by Shinancao on 2016/12/4.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import XCTest
import BehaviorDemo

class CheckCodeBehaviorTests: XCTestCase {
    
    var behavior: CheckCodeBehavior!
    
    override func setUp() {
        super.setUp()
        
        //模拟连接到该behavior上的控件
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        let button = UIButton(type: .roundedRect)
        
        behavior = CheckCodeBehavior()
        
        behavior.phoneTextField = textField
        
        button.addTarget(behavior, action: #selector(behavior.checkCodeButtonTapped), for: .touchUpInside)
        behavior.checkCodeButton = button
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testButtonIsSet() {
        XCTAssertNotNil(behavior.checkCodeButton, "checkCodeButton is nil")
    }
    
    func testTextFieldIsSet() {
        XCTAssertNotNil(behavior.phoneTextField, "phoneTextField is nil")
    }
    
    func testButtonDisableWithWrongPhoneNumber() {
        //given
        behavior.checkCodeButton.isEnabled = true
        behavior.phoneTextField.text = "1560"
        //when
        behavior.phoneTextField.sendActions(for: .editingChanged)
        //then
        XCTAssertFalse(behavior.checkCodeButton.isEnabled, "checkCodeButton  enable with a wrong phone number")
    }
    
    func testButtonEnableWithCorrectPhoneNumber() {
        //given
        behavior.checkCodeButton.isEnabled = false
        behavior.phoneTextField.text = "15601767079"
        //when
        behavior.phoneTextField.sendActions(for: .editingChanged)
        //then
        XCTAssertTrue(behavior.checkCodeButton.isEnabled, "checkCodeButton disable with a correct phone number")
    }
    
    func testCountdown() {
        //given
        behavior.waitSeconds = 5
        behavior.countingTitle = "剩余%d秒"
        //when
        behavior.checkCodeButton.sendActions(for: .touchUpInside)
        //then
        print("about to wait")
        XCTAssertEqual(behavior.checkCodeButton.titleLabel?.text, "剩余5秒")
        let runUtil = Date(timeIntervalSinceNow: 2)
        RunLoop.current.run(until: runUtil)
        print("wait time is over")
        XCTAssertEqual(behavior.checkCodeButton.titleLabel?.text, "剩余3秒")
    }
    
    func testCountdownOver() {
        //given
        let time = 5
        let title = "发送验证码"
        behavior.waitSeconds = time
        behavior.normalTitle = title
        //when
        behavior.checkCodeButton.sendActions(for: .touchUpInside)
        //then
        let runUtil = Date(timeIntervalSinceNow: Double(time))
        RunLoop.current.run(until: runUtil)
        XCTAssertEqual(behavior.checkCodeButton.titleLabel?.text, title)
    }
    
    func testSetCornerRadius() {
        //given
        let r: CGFloat = 5
        behavior.cornerRadius = r
        //when
        let button = UIButton(type: .roundedRect)
        behavior.checkCodeButton = button
        //then
        XCTAssertEqual(behavior.checkCodeButton.layer.cornerRadius, r)
    }
    
    func testSetBorderWidth() {
        //given
        let w: CGFloat = 2
        behavior.borderWidth = w
        //when
        let button = UIButton(type: .roundedRect)
        behavior.checkCodeButton = button
        //then
        XCTAssertEqual(behavior.checkCodeButton.layer.borderWidth, w)
    }
    
    func testSetTitleColor() {
        //given
        behavior.normalTitleColor = UIColor.blue
        behavior.disableTitleColor = UIColor.darkGray
        //when
        let button = UIButton(type: .roundedRect)
        behavior.checkCodeButton = button
        //then
        XCTAssertEqual(behavior.checkCodeButton.titleColor(for: .normal), UIColor.blue)
        XCTAssertEqual(behavior.checkCodeButton.titleColor(for: .disabled), UIColor.darkGray)
    }
    
    func testSetEnableStatus() {
        //given
        behavior.normalBorderColor = UIColor.blue
        behavior.normalBackgroundColor = UIColor.brown
        //when
        behavior.initialState = 1
        let button = UIButton(type: .roundedRect)
        behavior.checkCodeButton = button
        //then
        XCTAssertEqual(behavior.checkCodeButton.layer.borderColor, UIColor.blue.cgColor)
        XCTAssertEqual(behavior.checkCodeButton.backgroundColor, UIColor.brown)
    }
    
    func testSetDisableStatus() {
        //given
        behavior.disableBorderColor = UIColor.gray
        behavior.disableBackgroundColor = UIColor.green
        //when
        behavior.initialState = 0
        let button = UIButton(type: .roundedRect)
        behavior.checkCodeButton = button
        //then
        XCTAssertEqual(behavior.checkCodeButton.layer.borderColor, UIColor.gray.cgColor)
        XCTAssertEqual(behavior.checkCodeButton.backgroundColor, UIColor.green)
    }
}
