//
//  HBTableViewController.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBModelViewController.h"
#import "HBTableViewDataSource.h"

@interface HBTableViewController : HBModelViewController <UITableViewDelegate>

@property(nonatomic, strong) id <HBTableViewDataSource> dataSource;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) PullLoadType pullLoadType;
@property(nonatomic, assign) NSInteger newItemsCount;
@property(nonatomic, assign) int page;
/**
 能否上拉更多 default YES
 */
@property(nonatomic, assign) BOOL loadMoreEnable;
/**
 能否下拉刷新 default YES
 */
@property(nonatomic, assign) BOOL loadRefreshEnable;


#pragma mark - TableView

- (UITableViewStyle)tableViewStyle;

- (CGRect)tableViewFrame;

/**
 reloadData [self.tableView reloadData];
 */
- (void)reloadData;

/**
 点击跳转方法
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (void)didBeginDragging;

- (void)didEndDragging;


#pragma mark - Load

/**
 自动下拉刷新
 */
- (void)autoPullDown;

/**
 刷新数据
 */
- (void)refreshForNewData;

/**
 下拉刷新
 */
- (void)loadNewData;

/**
 上拉更多
 */
- (void)loadMoreData;

/**
 结束下拉刷新
 */
- (void)endRefresh;

/**
 结束上拉更多
 */
- (void)endLoadMore;

/**
 结束上下拉状态
 带延时动画
 */
- (void)endPullStatus;

/**
 结束上下拉状态 加载失败 to do
 带延时动画
 */
- (void)endPullStatusFail;

/**
 TableView DataSource
 */
- (void)createDataSource;

/**
 处理页面是否能继续上拉更多
 */
- (void)handleWhenLessOnePage;

/**
 展示空页面
 */
- (void)handleWhenNoneData;


@end
