//
//  NavBarGradientBehavior.swift
//  BehaviorDemo
//
//  Created by Shinancao on 16/8/28.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import UIKit

class NavBarGradientBehavior: Behavior, UIScrollViewDelegate {
    
    @IBInspectable var NavBarColor: UIColor!
    @IBInspectable var NavBarChangePoint: Float = 50
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewController = self.owner as! UIViewController
        let offsetY = Float(scrollView.contentOffset.y)
        if offsetY > NavBarChangePoint {
            let alpha = min(1, 1 - ((NavBarChangePoint + 64 - offsetY) / 64))
            viewController.navigationController?.navigationBar.lt_setBackgroundColor(NavBarColor.withAlphaComponent(CGFloat(alpha)))
        } else {
            viewController.navigationController?.navigationBar.lt_setBackgroundColor(NavBarColor.withAlphaComponent(0))
        }
    }
    

}
