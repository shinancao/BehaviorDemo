//
//  CheckCodeBehavior.swift
//  BehaviorDemo
//
//  Created by Shinancao on 16/8/21.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import UIKit

enum CheckCodeButtonState: Int {
    case normalAndDisable = 0, normalAndEnable, begin, waiting
}

public class CheckCodeBehavior: Behavior {
    fileprivate var timer: Timer?  //用于倒计时的定时器
    fileprivate var counter: Int = 0 //用于计数是否要停止定时器
    
    @IBOutlet weak public var phoneTextField: UITextField! {
        didSet {
            phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak public var checkCodeButton: UIButton! {
        didSet {
            setupButton()
            setCurrentState(CheckCodeButtonState(rawValue: initialState)!)
        }
    }

    @IBInspectable public var cornerRadius: CGFloat = 0
    @IBInspectable public var borderWidth: CGFloat = 0
    @IBInspectable public var normalTitleColor: UIColor?
    @IBInspectable public var disableTitleColor: UIColor?
    @IBInspectable public var normalBorderColor: UIColor?
    @IBInspectable public var disableBorderColor: UIColor?
    @IBInspectable public var normalBackgroundColor: UIColor?
    @IBInspectable public var disableBackgroundColor: UIColor?
    @IBInspectable public var normalTitle: String = "发送验证码"
    @IBInspectable public var countingTitle: NSString = "%d秒"
    
    @IBInspectable public var waitSeconds: Int = 60
    @IBInspectable public var initialState: Int = CheckCodeButtonState.normalAndDisable.rawValue
    
    fileprivate func setupButton() {
        if cornerRadius > 0 {
            checkCodeButton.layer.cornerRadius  = cornerRadius
            checkCodeButton.layer.masksToBounds = true
        }
        if borderWidth > 0 {
            checkCodeButton.layer.borderWidth = borderWidth
        }
        checkCodeButton.setTitleColor(normalTitleColor, for: .normal)
        checkCodeButton.setTitleColor(disableTitleColor, for: .disabled)
    }
    
    fileprivate func setButtonEnable() {
        checkCodeButton.isEnabled = true
        checkCodeButton.layer.borderColor = normalBorderColor?.cgColor
        checkCodeButton.backgroundColor = normalBackgroundColor
    }
    
    fileprivate func setButtonDisable() {
        checkCodeButton.isEnabled = false
        checkCodeButton.layer.borderColor = disableBorderColor?.cgColor
        checkCodeButton.backgroundColor = disableBackgroundColor
    }
    
    fileprivate func setButtonNormal() {
        if checkCodeButton.isEnabled {
            checkCodeButton.setTitle(normalTitle, for: .normal)
        } else {
            checkCodeButton.setTitle(normalTitle, for: .disabled)
        }
    }
    
    fileprivate func beginCounting() {
        setButtonDisable()
        counter = waitSeconds
        checkCodeButton.setTitle(NSString(format: countingTitle, counter) as String, for: UIControlState.disabled)
        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc fileprivate func timerAction() {
        //当返回到上一个页面时，button会销毁，所以为了放置button为nil而崩溃，加上一个判断。并且一旦button不存在了就释放timer，这样该behavior就跟着一起被销毁了，若不释放就不会销毁。
        guard let button = checkCodeButton else {
            timer?.invalidate()
            timer = nil
            return
        }
        
        counter -= 1
        if counter == 0 {
            timer?.invalidate()
            timer = nil
            setCurrentState(.normalAndEnable)
        } else {
            button.setTitle(NSString(format: countingTitle, counter) as String, for: UIControlState.disabled)
        }
    }
    
    func setCurrentState(_ state: CheckCodeButtonState) {
        switch state {
        case .normalAndDisable:
            setButtonDisable()
            setButtonNormal()
        case .normalAndEnable:
            setButtonEnable()
            setButtonNormal()
        case .begin:
            beginCounting()
        case .waiting:
            break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text
            else {return}
        if validatePhone(text) {
            setCurrentState(.normalAndEnable)
        } else {
            setCurrentState(.normalAndDisable)
        }
    }
    
    fileprivate func validatePhone(_ phone: String) -> Bool {
        let phoneRegex = "1[3|5|7|8][0-9]{9}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    @IBAction public func checkCodeButtonTapped(_ sender: AnyObject) {
        setCurrentState(.begin)
        sendActions(for: .touchUpInside)
    }
}
