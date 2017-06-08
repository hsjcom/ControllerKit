//
//  HBRefreshHeader.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/8.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBRefreshHeader.h"

@implementation HBRefreshHeader

- (void)prepare {
    [super prepare];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    self.stateLabel.hidden = YES;
    
    NSMutableArray *idleImages = [NSMutableArray array];
    [idleImages addObject:[UIImage imageNamed:@"refreshLoading1"]];
    
    NSMutableArray *pullImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshLoading%zd", i]];
        [pullImages addObject:image];
    }
    
    NSTimeInterval duration = 0.5;
    
    // 设置普通状态的动画图片
    [self setImages:idleImages duration:duration forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:pullImages duration:duration forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:pullImages duration:duration forState:MJRefreshStateRefreshing];
}

@end
