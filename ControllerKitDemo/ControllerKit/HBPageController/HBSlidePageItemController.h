//
//  HBSlidePageItemController.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBTableViewController.h"
#import "HBSlidePageController.h"

/**
 * 注意
 * viewDidLoad 里不能调 createModel
 */

@interface HBSlidePageItemController : HBTableViewController {
    CGFloat _lastPositionY;
}

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, weak) id<HBSlidePageDelegate> spDelegate;

/**
 * @require
 * reload model 数据，根据子类的数据类型 重写
 */
- (void)reloadModel:(HBSlidePageModel *)model;

/**
 * @require
 */
- (void)initialPageIndex:(NSInteger)index;

- (void)initialQuery:(NSDictionary *)query;

- (void)loadDataFromCache;

@end
