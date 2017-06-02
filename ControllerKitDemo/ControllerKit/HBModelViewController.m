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



@end
