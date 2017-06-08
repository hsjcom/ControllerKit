//
//  HBRefreshFooter.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/8.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBRefreshFooter.h"

@implementation HBRefreshFooter

- (void)prepare {
    [super prepare];
    
    [self setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [self setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"- END -" forState:MJRefreshStateNoMoreData];
    self.stateLabel.font = [UIFont systemFontOfSize:17];
}


@end
