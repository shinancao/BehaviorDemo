//
//  AssociatedToOwenerBehavior.m
//  BehaviorDemo
//
//  Created by Shinancao on 2016/10/30.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

#import "BindedToOwnerBehavior.h"
#import <objc/runtime.h>

@implementation BindedToOwnerBehavior

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"BindedToOwnerBehavior init");
    }
    return self;
}

- (void)dealloc {
    NSLog(@"BindedToOwnerBehavior dealloc");
}

- (void)setOwner:(id)owner {
    if (_owner != owner) {
        [self releaseLifetimeFromObject:_owner];
        _owner = owner;
        [self bindLifetimeToObject:_owner];
    }
}

- (void)bindLifetimeToObject:(id)object {
    objc_setAssociatedObject(object, (__bridge void *)self, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseLifetimeFromObject:(id)object {
    objc_setAssociatedObject(object, (__bridge void *)self, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
