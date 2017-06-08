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
    
    [self setTitle:@"" forState:MJRefreshStateIdle];
//    [self setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"--  END  --" forState:MJRefreshStateNoMoreData];
    self.stateLabel.font = [UIFont systemFontOfSize:16];
    
    // 隐藏刷新状态的文字
    self.refreshingTitleHidden = YES;
//    self.stateLabel.hidden = YES;
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
//    footer.triggerAutomaticallyRefreshPercent = 0.5;
    
    NSMutableArray *pullImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshLoading%zd", i]];
        [pullImages addObject:image];
    }
    
    // 设置正在刷新状态的动画图片
    [self setImages:pullImages duration:0.5 forState:MJRefreshStateRefreshing];
}


@end
