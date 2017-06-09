//
//  HBCollectionViewController.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBModelViewController.h"
#import "HBCollectionViewDataSource.h"

@interface HBCollectionViewController : HBModelViewController <UICollectionViewDelegate>

@property(nonatomic, strong) id <HBCollectionViewDataSource> dataSource;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, assign) PullLoadType pullLoadType;
@property(nonatomic, assign) NSInteger newItemsCount;
@property(nonatomic, assign) int page;
/**
 能否继续上拉更多 default YES
 */
@property(nonatomic, assign) BOOL loadMoreEnable;


#pragma mark - CollectionView

/**
 初始化注册cell & Identifier
 */
- (void)collectionViewRegisterCellClassAndReuseIdentifier;

- (CGRect)collectionViewFrame;

- (void)reloadData;

/**
 cell 点击跳转方法
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (void)didBeginDragging;

- (void)didEndDragging;


#pragma mark - CollectionLayout

#pragma mark  Default One Section

/**
 设置collectionView的内容有几列
 */
- (NSUInteger)numOfRows;

/**
 列间距
 */
- (CGFloat)XPadding;

/**
 行间距
 */
- (CGFloat)YPadding;

/**
 设置collectionView的前后左右的间距
 */
- (UIEdgeInsets)layoutEdgeInsets;

#pragma mark Muti Sections

/**
 设置collectionView的内容有几列 Muti
 */
- (NSMutableArray *)numOfRowsMuti;

/**
 列间距 Muti
 */
- (NSMutableArray *)XPaddingMuti;

/**
 行间距 Muti
 */
- (NSMutableArray *)YPaddingMuti;

/**
 设置collectionView的前后左右的间距 Muti
 */
- (NSMutableArray *)layoutEdgeInsetsMuti;


#pragma mark - Load

/**
 是否开启下拉刷新 default YES
 */
- (BOOL)canLoadRefreshEnable;

/**
 是否开启上拉更多 default YES
 */
- (BOOL)canLoadMoreEnable;

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
