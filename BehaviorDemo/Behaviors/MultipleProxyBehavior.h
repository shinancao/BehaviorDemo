//
//  KIZMultipleProxyBehavior.h
//  KIZParallaTableDemo https://github.com/zziking/KIZBehavior
//
//  Created by kingizz on 15/8/17.
//  Copyright (c) 2015年 kingizz. All rights reserved.
//

#import "Behavior.h"

@interface MultipleProxyBehavior : Behavior

@property (nonatomic, strong) IBOutletCollection(id) NSArray* delegateTargets;

@end
