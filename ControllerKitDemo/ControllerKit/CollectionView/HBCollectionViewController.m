//
//  HBCollectionViewController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBCollectionViewController.h"
#import "HBCollectionViewCell.h"
#import "HBCollectionViewHeaderView.h"
#import "HBCollectionViewFooterView.h"
#import "HBCollectionViewLayout.h"
#import "MJRefresh.h"
#import "HBRefreshFooter.h"
#import "HBRefreshHeader.h"

@interface HBCollectionViewController ()

@end




@implementation HBCollectionViewController

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _dataSource = nil;
    _collectionView = nil;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.page = 1;
        self.items = [NSMutableArray arrayWithCapacity:0];
        self.pullLoadType = PullDefault;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self collectionView];
    [self configCollectionLayout];
}

#pragma mark - CollectionView

- (UICollectionView *)collectionView {
    if (!_collectionView){
        HBCollectionViewLayout *layout = [[HBCollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:[self collectionViewFrame] collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        [self collectionViewRegisterCellClassAndReuseIdentifier];
    }
    return _collectionView;
}

/**
 初始化注册cell & Identifier
 */
- (void)collectionViewRegisterCellClassAndReuseIdentifier {
    [_collectionView registerClass:[HBCollectionViewCell class] forCellWithReuseIdentifier:@"HBCollectionViewCell"];
    [self.collectionView registerClass:[HBCollectionViewHeaderView class]  forSupplementaryViewOfKind:HBCollectionViewHeader withReuseIdentifier:@"HBCollectionViewHeader"];
    [self.collectionView registerClass:[HBCollectionViewFooterView class]  forSupplementaryViewOfKind:HBCollectionViewFooter withReuseIdentifier:@"HBCollectionViewFooter"];
}

- (CGRect)collectionViewFrame {
    CGRect rect = self.view.bounds;
    return rect;
}

- (void)setDataSource:(id <HBCollectionViewDataSource>)dataSource{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        _collectionView.dataSource = _dataSource;
        [_collectionView reloadData];
    }
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - CollectionLayout

/**
 CollectionLayout
 UICollectionViewDelegateFlowLayout
 */
- (void)configCollectionLayout {
    NSMutableArray *numOfRowsMuti = [self numOfRowsMuti];
    if (!numOfRowsMuti) {
        numOfRowsMuti = [NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedLong:[self numOfRows]]];
    }
    self.layout.numberOfItemsPerLines = numOfRowsMuti;
    
    NSMutableArray *XPaddingMuti = [self XPaddingMuti];
    if (!XPaddingMuti) {
        XPaddingMuti = [NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedLong:[self XPadding]]];
    }
    self.layout.XSpacings = XPaddingMuti;
    
    NSMutableArray *YPaddingMuti = [self YPaddingMuti];
    if (!YPaddingMuti) {
        YPaddingMuti = [NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedLong:[self YPadding]]];
    }
    self.layout.YSpacings = YPaddingMuti;
    
    NSMutableArray *layoutEdgeInsetsMuti = [self layoutEdgeInsetsMuti];
    if (!layoutEdgeInsetsMuti) {
        NSString *string = NSStringFromUIEdgeInsets([self layoutEdgeInsets]);
        layoutEdgeInsetsMuti = [NSMutableArray arrayWithObject:string];
    }
    self.layout.sectionInsets = layoutEdgeInsetsMuti;
}

- (HBCollectionViewLayout *)layout {
    return (id)self.collectionView.collectionViewLayout;
}

#pragma mark  Default One Section

/**
 设置collectionView的内容有几列
 */
- (NSUInteger)numOfRows {
    return 2;
}

/**
 列间距
 */
- (CGFloat)XPadding {
    return 5.f;
}

/**
 行间距
 */
- (CGFloat)YPadding {
    return 5.f;
}

/**
 设置collectionView的前后左右的间距
 */
- (UIEdgeInsets)layoutEdgeInsets {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark Muti Sections

/**
 设置collectionView的内容有几列 Muti
 */
- (NSMutableArray *)numOfRowsMuti {
    return nil;
}

/**
 列间距 Muti
 */
- (NSMutableArray *)XPaddingMuti {
    return nil;
}

/**
 行间距 Muti
 */
- (NSMutableArray *)YPaddingMuti {
    return nil;
}

/**
 设置collectionView的前后左右的间距 Muti
 */
- (NSMutableArray *)layoutEdgeInsetsMuti {
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    id <HBCollectionViewDataSource> dataSource = (id <HBCollectionViewDataSource>) collectionView.dataSource;
    id object = [dataSource collectionView:collectionView objectForRowAtIndexPath:indexPath];
    [self didSelectObject:object atIndexPath:indexPath];
}

/**
 cell 点击跳转方法
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    
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
 是否开启下拉刷新 default YES
 */
- (BOOL)canLoadRefreshEnable {
    return YES;
}

/**
 是否开启上拉更多 default YES
 */
- (BOOL)canLoadMoreEnable {
    return YES;
}

- (void)configRefresh {
    self.page = 1;
    self.pullLoadType = PullDefault;
    
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    if (self.canLoadRefreshEnable) {
        self.collectionView.mj_header = [HBRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
    }
    
    if (self.canLoadMoreEnable) {
        self.loadMoreEnable = YES;
        
        //上拉更多
        HBRefreshFooter *footer = [HBRefreshFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        
        self.collectionView.mj_footer = footer;
    }
}

#pragma mark - Load

/**
 自动下拉刷新
 */
- (void)autoPullDown {
    // 马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
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
    if (self.collectionView.mj_header) {
        [self.collectionView.mj_header endRefreshing];
    }
    
    if (!self.loadMoreEnable) {
        if (self.collectionView.mj_footer) {
            [self.collectionView.mj_footer endRefreshing];
        }
    }
}

/**
 结束上拉更多
 */
- (void)endLoadMore {
    self.pullLoadType = PullDefault;
    if (self.collectionView.mj_footer) {
        if (!self.loadMoreEnable) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.collectionView.mj_footer endRefreshing];
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
 CollectionView DataSource
 */
- (void)createDataSource {
    /*
     self.dataSource = [HBCollectionViewDataSource dataSourceWithItems:self.items];
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
         self.loadMoreEnable = YES;
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
