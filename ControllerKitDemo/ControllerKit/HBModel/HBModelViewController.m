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

- (void)modelDidFinishLoad:(id)request {
    /*
     数据解析
     */
}

- (void)modeldidFailLoadWithError:(id)request {
}

- (void)onLoadFailed {
    
}

- (void)onDataUpdated {
    
}



@end
