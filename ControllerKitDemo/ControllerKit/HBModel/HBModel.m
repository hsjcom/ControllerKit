//
//  HBModel.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBModel.h"

@implementation HBModel

- (void)dealloc{
    if (_modelController) {
        _modelController = nil;
    }
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:0];
    }
    return _items;
}


@end
