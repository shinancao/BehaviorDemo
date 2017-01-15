//
//  MultipleProxyBehaviorTests.m
//  BehaviorDemo
//
//  Created by Shinancao on 2016/12/11.
//  Copyright © 2016年 ZhangNan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MultipleProxyBehavior.h"

@interface ScrollViewDelegateOne : NSObject <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL delegateCalled;

@end


@implementation ScrollViewDelegateOne

- (instancetype)init {
    if (self = [super init]) {
        _delegateCalled = NO;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _delegateCalled = YES;
}

@end

@interface ScrollViewDelegateTwo : NSObject <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL delegateCalled;

@end

@implementation ScrollViewDelegateTwo

- (instancetype)init {
    if (self = [super init]) {
        _delegateCalled = NO;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _delegateCalled = YES;
}

@end


@interface MultipleProxyBehaviorTests : XCTestCase

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MultipleProxyBehavior *behavior;
@property (nonatomic, strong) ScrollViewDelegateOne *delegateOne;
@property (nonatomic, strong) ScrollViewDelegateTwo *delegateTwo;
@end

@implementation MultipleProxyBehaviorTests

- (void)setUp {
    [super setUp];
    
    _delegateOne = [[ScrollViewDelegateOne alloc] init];
    _delegateTwo = [[ScrollViewDelegateTwo alloc] init];
    
    _behavior = [[MultipleProxyBehavior alloc] init];
    _behavior.delegateTargets = @[_delegateOne, _delegateTwo];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _scrollView.contentSize = CGSizeMake(200, 300);
    _scrollView.delegate = (id)_behavior;
}

- (void)tearDown {
    [super tearDown];
    
}

- (void)testScrollViewDelegateCalled {
    [_scrollView setContentOffset:CGPointMake(0, 50)];
    
    XCTAssertTrue(_delegateOne.delegateCalled, @"scrollViewDidScroll is not called");
    XCTAssertTrue(_delegateTwo.delegateCalled, @"scrollViewDidScroll is not called");
}

@end
