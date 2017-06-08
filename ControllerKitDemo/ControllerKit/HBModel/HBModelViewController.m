//
//  HBModelViewController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/2.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBModelViewController.h"

@interface HBModelViewController ()

@end

@implementation HBModelViewController

- (void)dealloc {
    _items = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:0];
    }
    return _items;
}

- (NSString *)requestUrl {
    return nil;
}

- (NSUInteger)cacheTime {
    return 0;
}

/*
- (HBReqSystemType)reqSysType{
    return TTREQ_DEFAULT;
}
 */

- (void)createModel {
    /*
     网络模块
     */
}

- (void)didFinishLoad:(id)request {
    [self modelDidFinishLoad:request];
    [self onDataUpdated];
}

- (void)didFailLoadWithError:(id)request {
    [self modeldidFailLoadWithError:request];
    [self onLoadFailed];
}

/**
 model Did Start
 处理Loading 等
 */
- (void)modelDidStartLoad {
//    [self showLoading:YES];
}


/**
 model 请求完成
 处理数据解析 等
 */
- (void)modelDidFinishLoad:(id)request {
    /*
     数据解析
     */
}

/**
 model 请求失败
 */
- (void)modeldidFailLoadWithError:(id)request {
}

/**
 加载失败更新
 */
- (void)onLoadFailed {
//    [self showLoading:NO];
}

/**
 加载成功更新
 */
- (void)onDataUpdated {
//    [self showLoading:NO];
    
}



@end
