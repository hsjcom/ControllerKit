//
//  HBLayout.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBLayout.h"

@implementation HBLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellHeight = 0;
        self.textHeight = 0;
    }
    return self;
}

- (void)resetCellHeight {
    self.cellHeight = 0;
    self.textHeight = 0;
}

@end
