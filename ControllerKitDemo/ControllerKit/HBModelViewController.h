//
//  HBModelViewController.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/2.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBViewController.h"


/**
 刷新类型

 - PullDefault: 默认类型
 - PullDownRefresh: 下拉刷新
 - PullUpLoadMore: 上拉更多
 */
typedef NS_ENUM(NSInteger, PullLoadType) {
    PullDefault = 0,
    PullDownRefresh = 1,
    PullUpLoadMore  = 2,
};


@interface HBModelViewController : HBViewController


/**
 数据源items
 */
@property(nonatomic, strong) NSMutableArray *items;

@end
