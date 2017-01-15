//
//  AssociatedToOwenerBehavior.h
//  BehaviorDemo
//
//  Created by Shinancao on 2016/10/30.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindedToOwnerBehavior : NSObject

@property (nonatomic, weak) IBOutlet id owner;

@end
