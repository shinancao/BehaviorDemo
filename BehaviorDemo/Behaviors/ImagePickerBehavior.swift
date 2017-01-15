//
//  ImagePickerBehavior.swift
//  BehaviorDemo
//
//  Created by Shinancao on 16/8/27.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

import UIKit
import AVFoundation

public class ImagePickerBehavior: Behavior, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak public var targetImageView: UIImageView!
    
    //调出ActionSheet
    fileprivate func startGetPhoto() {
        let alertControl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let albumAction = UIAlertAction(title: "相册", style: .default) { (action) in
            self.localPhoto()
        }
        let cameraAction = UIAlertAction(title: "相机", style: .default) { (action) in
            self.takePhoto()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .default) { (action) in
            
        }
        alertControl.addAction(albumAction)
        alertControl.addAction(cameraAction)
        alertControl.addAction(cancelAction)
        
        let viewController = self.owner as! UIViewController
        viewController.present(alertControl, animated: true, completion: nil)
    }
    
    //打开本地相册
    fileprivate func localPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        let viewController = self.owner as! UIViewController
        viewController.present(picker, animated: true, completion: nil)
    }
    
    //打开摄像头
    fileprivate func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            
            let viewController = self.owner as! UIViewController
            
            //检查是否开启相机权限
            if checkCamera() {
                viewController.present(picker, animated: true, completion: nil)
            } else {
                let alertControl = UIAlertController(title: "提示", message: "请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。", preferredStyle: .alert)
                viewController.present(alertControl, animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func checkCamera() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied {
            return false
        } else {
            return true
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let type = info[UIImagePickerControllerMediaType] as! String
        
        if type == "public.image" {
            var key: String
            if picker.allowsEditing {
                key = UIImagePickerControllerEditedImage
            } else {
                key = UIImagePickerControllerOriginalImage
            }
            
            //获取图片
            let image: UIImage = info[key] as! UIImage
            targetImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction public func picImageFromButton(_ sender: AnyObject) {
        startGetPhoto()
    }
}
