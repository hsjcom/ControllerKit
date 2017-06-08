//
//  HBTableViewController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBTableViewController.h"
#import "HBTableViewCell.h"
#import "HBLayout.h"
#import "MJRefresh.h"
#import "HBRefreshFooter.h"
#import "HBRefreshHeader.h"


@interface HBTableViewController ()

@end


@implementation HBTableViewController

- (void)dealloc {
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
    _dataSource = nil;
    _tableView = nil;
}

- (id)initWithQuery:(NSDictionary *)query {
    self = [super initWithQuery:query];
    if (self) {
        self.page = 1;
        self.pullLoadType = PullDefault;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    [self configRefresh];
    
//    [self createModel];
}

#pragma mark - TableView

- (UITableView *)tableView {
    if (nil == _tableView){
        _tableView = [[UITableView alloc] initWithFrame:[self tableViewFrame] style:[self tableViewStyle]];
        _tableView.backgroundColor = [self backgroundColor];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}

- (CGRect)tableViewFrame {
    CGRect rect = self.view.bounds;
    return rect;
}

- (void)setDataSource:(id <HBTableViewDataSource>)dataSource{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        self.tableView.dataSource = _dataSource;
        [self reloadData];
    }
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id <HBTableViewDataSource> dataSource = (id <HBTableViewDataSource>) tableView.dataSource;
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    
    CGFloat height = 0;
    /**
     * 优化cell高度计算
     */
    if ([object isKindOfClass:[HBLayout class]]) {
        HBLayout *layout = (HBLayout *)object;
        if (layout.cellHeight > 0) {
            return layout.cellHeight;
        }
        Class cls = [dataSource tableView:tableView cellClassForObject:object];
        height = [cls tableView:tableView rowHeightForObject:object];
        layout.cellHeight = height;
        return height;
        
    } else {
        Class cls = [dataSource tableView:tableView cellClassForObject:object];
        height = [cls tableView:tableView rowHeightForObject:object];
        return height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id <HBTableViewDataSource> dataSource = (id <HBTableViewDataSource>) tableView.dataSource;
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    [self didSelectObject:object atIndexPath:indexPath];
}

/**
 点击跳转方法
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self didBeginDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self didEndDragging];
}

- (void)didBeginDragging {
}

- (void)didEndDragging {
}

#pragma mark - 下拉刷新 & 上拉更多

/**
 能否下拉刷新 default YES
 */
- (BOOL)loadRefreshEnable {
    return YES;
}

/**
 能否上拉更多 default YES
 */
- (BOOL)loadMoreEnable {
    return YES;
}

- (void)configRefresh {
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    if (self.loadRefreshEnable) {
        self.tableView.mj_header = [HBRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
    }
    
    if (self.loadMoreEnable) {
        //上拉更多
        HBRefreshFooter *footer = [HBRefreshFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        
        self.tableView.mj_footer = footer;
    }
}

#pragma mark - Load 

/**
 自动下拉刷新
 */
- (void)autoPullDown {
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

/**
 刷新数据
 */
- (void)refreshForNewData {
    self.pullLoadType = PullDownRefresh;
    self.page = 1;
    [self createModel];
}

/**
 下拉刷新
 */
- (void)loadNewData {
    [self refreshForNewData];
}

/**
 上拉更多
 */
- (void)loadMoreData {
    self.pullLoadType = PullUpLoadMore;
    self.page ++;
    [self createModel];
}

/**
 结束下拉刷新
 */
- (void)endRefresh {
    self.pullLoadType = PullDefault;
    if (self.tableView.mj_header) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (!self.loadMoreEnable) {
        if (self.tableView.mj_footer) {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

/**
 结束上拉更多
 */
- (void)endLoadMore {
    self.pullLoadType = PullDefault;
    if (self.tableView.mj_footer) {
        if (!self.loadMoreEnable) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

/**
 结束上下拉状态
 带延时动画
 */
- (void)endPullStatus {
    if (self.pullLoadType == PullUpLoadMore) {
        [self endLoadMore];
    } else {
        [self performSelector:@selector(endRefresh) withObject:nil afterDelay:0.62];
    }
}

/**
 结束上下拉状态 加载失败 to do
 带延时动画
 */
- (void)endPullStatusFail {
    [self endPullStatus];
}

- (void)onDataUpdated {
    [super onDataUpdated];
    
    [self createDataSource];
    
    [self handleWhenLessOnePage];
    [self handleWhenNoneData];
    
    [self endPullStatus];
}

- (void)onLoadFailed {
    [super onLoadFailed];
    
    [self endPullStatusFail];
}

/**
 TableView DataSource
 */
- (void)createDataSource {
    /*
    self.dataSource = [HBTableViewDataSource dataSourceWithItems:self.items];
     */
}

/**
 处理页面是否能继续上拉更多
 */
- (void)handleWhenLessOnePage {
    /*
     if (self.items.count < limitSize || self.newItemsCount <= 0) {
     self.loadMoreEnable = NO;
     } else{
     self.loadMoreEnable = NO;
     }
     */
}

/**
 展示空页面
 */
- (void)handleWhenNoneData {
    
}

- (void)modelDidFinishLoad:(id)request {
    /*
    if (self.pullLoadType == PullDownRefresh) {
        [self.items removeAllObjects];
    }
    
     数据解析
     */
}

@end
