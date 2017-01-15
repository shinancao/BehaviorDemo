//
//  BackgroundGradientBehavior.swift
//  BehaviorDemo
//
//  Created by Shinancao on 16/8/27.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import UIKit

class BackgroundGradientBehavior: Behavior, UIScrollViewDelegate {

    fileprivate let kInterpolateStagesWithAlpha = true
    fileprivate var isInitBlurredImagesFinished = false
    fileprivate var blurredImages: [UIImage] = []
    fileprivate var originalImage: UIImage!
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBInspectable var ScrollViewTravel: Double = 200.0
    @IBInspectable var MaxBlurRadius: Double = 25.0
    @IBInspectable var NumberOfStages: Int = 10
    @IBInspectable var OriginalImageName: String? {
        didSet {
            if let realImgName = OriginalImageName {
                originalImage = UIImage(named: realImgName)
                initBlurredImages()
            }
        }
    }
    
    fileprivate func initBlurredImages() {
        DispatchQueue.global().async {
            [weak self] in
            if let strongSelf = self {
                strongSelf.blurredImages.append(strongSelf.originalImage)
                
                for i in 1...strongSelf.NumberOfStages {
                    let radius = Double(i) * strongSelf.MaxBlurRadius / Double(strongSelf.NumberOfStages)
                    let blurredImage = strongSelf.blurOriginalImageWithRadius(radius)
                    strongSelf.blurredImages.append(blurredImage)
                    
                    if i == strongSelf.NumberOfStages {
                        strongSelf.blurredImages.append(blurredImage)
                    }
                }
                
                DispatchQueue.main.async(execute: { 
                    strongSelf.isInitBlurredImagesFinished = true
                })
            }
        }
    }
    
    fileprivate func blurOriginalImageWithRadius(_ radius: Double) -> UIImage {
        return UIImageEffects.imageByApplyingBlur(to: originalImage, withRadius: CGFloat(radius), tintColor: nil, saturationDeltaFactor: 1.0, maskImage: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isInitBlurredImagesFinished == false {
            return
        }
        
        let r = Double(scrollView.contentOffset.y / CGFloat(ScrollViewTravel))
        let blur = max(0, min(1, r)) * Double(NumberOfStages)
        let blurIndex = Int(blur)
        let blurRemainder = blur - Double(blurIndex)
        
        firstImageView.image = blurredImages[blurIndex]
        
        if kInterpolateStagesWithAlpha == true {
            secondImageView.image = blurredImages[blurIndex + 1]
            secondImageView.alpha = CGFloat(blurRemainder)
        }
    }
    
    // simple paging 如果需要滑动后停到指定位置可以实现改方法
//    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        var y = Double(targetContentOffset.memory.y)
//        y = (y < ScrollViewTravel / 2.0) ? 0: ScrollViewTravel
//        targetContentOffset.memory.y = CGFloat(y)
//    }
}
