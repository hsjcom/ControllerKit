//
//  HBSlidePageItemController.h
//  TaQu
//
//  Created by Soldier on 16/3/30.
//  Copyright © 2016年 厦门海豹信息技术. All rights reserved.
//

#import "HBTableViewController.h"
#import "ForumListController.h"

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
