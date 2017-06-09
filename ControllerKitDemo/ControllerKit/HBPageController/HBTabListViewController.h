//
//  HBTabListViewController.h
//  TaQu
//
//  Created by Soldier on 16/7/28.
//  Copyright © 2016年 厦门海豹信息技术. All rights reserved.
//

/**
 * 基于单个controller的多个tab列表数据切换controller
 * 下拉刷新位于最顶部
 * 支持保存多个tab列表所有数据，
 * 支持保存多个tab列表的contentOffset.y，包括存在tableHeaderView时的滑动交互
 * 效果与微博个人主页相似
 */

#import "HBTableViewController.h"

@interface HBTabListViewController : HBTableViewController

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) HBSlidePageModel *pageModel;
@property (nonatomic, strong) FDSlideBar *slideBar;
@property (nonatomic, strong) NSMutableArray *tabItems;
@property (nonatomic, strong) HBSlideTabItem *selectTabItem;

- (CGRect)slideBarFrame;

- (void)clickTapWithIndex:(NSInteger)index;

/**
 * 根据子类的数据类型 重写
 * 多次调用
 * 初始化[self pageIndex:0];  在初始化_slideBar数据后，create model 之前初始化
 */
- (void)pageIndex:(NSInteger)index;

/**
 * 更新page model
 * 在 createDataSource or onDataUpdated 调用
 */
- (void)updatePageModel;

/**
 * 生成用来存储的model,在子类重写
 */
- (id)createUpdatePageModel;

- (void)reloadDataMode;

/**
 * reload model 数据，根据子类的数据类型 重写
 */
- (void)reloadModel:(HBSlidePageModel *)model;

/**
 * 获取TabItem数据
 */
- (HBSlideTabItem *)getTabItem;

/**
 * 滑动到某个tab
 */
- (void)slideToTabWithIndex:(NSInteger)index;

/**
 * 调整 tableview contentSize.height
 * 当存在tableHeaderView时，self.tableView.contentSize.height < self.view.height + height的情况时
 * 根据需要看是否调用，建议在 onDataUpdated 最后调用
 */
- (void)adjustTableViewContentSizeHeight;


@end
