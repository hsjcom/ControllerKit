//
//  HBSlidePageController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//


#import "HBSlidePageController.h"
#import "HBSlidePageCell.h"
#import <objc/runtime.h>

@interface HBSlidePageController ()

@end





@implementation HBSlidePageController

- (void)dealloc {
    if (_mainColllectionView) {
        _mainColllectionView.delegate = nil;
        _mainColllectionView.dataSource = nil;
    }
}

- (id)initWithQuery:(NSDictionary *)query{
    self = [super initWithQuery:query];
    if (self) {
        self.pageIndex = 0;
        _isClickSlideBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self slideBar];
    [self mainColllectionView];
    
    //侧滑手势冲突解决方式
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    //当是侧滑手势的时候设置scrollview需要此手势失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [self.mainColllectionView.panGestureRecognizer requireGestureRecognizerToFail:gesture];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self cellControllerViewDisAppear];
    [self dismissAllVCKeyBoard];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //viewWillAppear cell可能取不到
    [self cellControllerViewAppear];
}

- (UICollectionView *)mainColllectionView {
    if (!_mainColllectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向
        flowLayout.itemSize = [self colllectionViewFrame].size;//item的大小
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing = 0.0;
        
        _mainColllectionView = [[UICollectionView alloc] initWithFrame:[self colllectionViewFrame] collectionViewLayout:flowLayout];
        _mainColllectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mainColllectionView];
        
        [_mainColllectionView registerClass:[HBSlidePageCell class] forCellWithReuseIdentifier:@"HBSlidePageCell"];
        _mainColllectionView.showsVerticalScrollIndicator = NO;
        _mainColllectionView.showsHorizontalScrollIndicator = NO;
        _mainColllectionView.pagingEnabled = YES;
        _mainColllectionView.dataSource = self;
        _mainColllectionView.delegate = self;
    }
    return _mainColllectionView;
}

- (CGRect)colllectionViewFrame {
    return CGRectMake(0, self.slideBar.height, self.view.width, self.view.height - self.slideBar.height);
}

- (void)registerCellIdentifierForView:(UICollectionView *)collectionView cellClass:(Class)cellClass{
    NSString *className = [self.class className:cellClass];
    [collectionView registerClass:cellClass forCellWithReuseIdentifier:className];
}

- (HBSlideBar *)slideBar {
    if (!_slideBar) {
        _slideBar = [[HBSlideBar alloc] initWithFrameWithoutFadeLayer:[self slideBarFrame]];
        _slideBar.backgroundColor = [UIColor whiteColor];
        _slideBar.itemColor = COLOR_G2;
        _slideBar.itemSelectedColor = COLOR_G1;
        _slideBar.sliderColor = COLOR_C1;
        _slideBar.sliderWidth = 30;
        _slideBar.sliderHeight = 4;
        _slideBar.sliderView.clipsToBounds = YES;
        _slideBar.sliderView.layer.cornerRadius = 2;
        __weak __typeof(self) weakSelf = self;
        [_slideBar slideBarItemSelectedCallback:^(NSUInteger idx) {
            if (weakSelf) {
                [weakSelf pageIndex:idx]; //确保self.page 正确
                [weakSelf.mainColllectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
                [weakSelf clickTapWithIndex:idx];
                weakSelf.isClickSlideBar = YES;
            }
        }];
        [self.view addSubview:_slideBar];
        
//        UIView *liner = [[UIView alloc] initWithFrame:CGRectMake(0, _slideBar.height - LINE_HEIGHT, _slideBar.width, LINE_HEIGHT)];
//        liner.backgroundColor = COLOR_L1;
//        liner.tag = 1490950879;//用于不用移除
//        [_slideBar addSubview:liner];
    }
    return _slideBar;
}

- (CGRect)slideBarFrame {
    return CGRectMake(0, 0, UI_SCREEN_WIDTH, 44);
}

- (void)setupSlideBarTabs:(NSArray <HBSlideTabItem *> *)tabItems {
    NSArray *tabTitles = [tabItems valueForKeyPath:@"tabName"];
    _slideBar.itemsTitle = tabTitles;
}

- (void)setTabItems:(NSMutableArray *)tabItems {
    if (!_tabItems) {
        _tabItems = [NSMutableArray new];
    }
    if (tabItems.count <= 0) {
        return;
    }
    
    _tabItems = tabItems;
    [self.mainColllectionView reloadData];
    
    [self setupSlideBarTabs:_tabItems];
    
    //这里设置生效
    _slideBar.itemColor = COLOR_G2;
    _slideBar.itemSelectedColor = COLOR_G1;
    _slideBar.titleFont = [UIFont systemFontOfSize:14];
    _slideBar.titleSelectedFont = [UIFont systemFontOfSize:14];
}

- (void)clickTapWithIndex:(NSInteger)index {
    
}

#pragma mark - UICollectionViewDataSource

/**
 * UICollectionViewDataSource 根据需要及数据模型在子类重写
 */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _tabItems.count > 0 ? _tabItems.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //本意是滑动时更新pageIndex，实际上滑动不创建新的cell时并不调用，滑动更新在ScrollviewDelegate已处理
//    [self pageIndex:indexPath.row];
    self.pageIndex = indexPath.row;
    
    /*
    HBSlidePageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HBSlidePageCell" forIndexPath:indexPath];
    [cell initWithQuery:[self controllersInitialQuary] delegate:self index:self.pageIndex];
    [cell reloadDataWithMode:[self reloadModelFromMianModel]];
    */
    
    Class cellClass = [self cellClass];
    const char *className = class_getName(cellClass);
    
    [self registerCellIdentifierForView:collectionView cellClass:cellClass];
    
    NSString *identifier = [[NSString alloc] initWithBytesNoCopy:(char *) className
                                                          length:strlen(className)
                                                        encoding:NSASCIIStringEncoding freeWhenDone:NO];
    
    UICollectionViewCell *cell = (UICollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[cellClass alloc] init];
    }
    
    if ([cell isKindOfClass:[HBSlidePageCell class]]) {
        [(HBSlidePageCell *)cell initWithQuery:[self controllersInitialQuary] delegate:self index:self.pageIndex];
        [(HBSlidePageCell *)cell reloadDataWithMode:[self reloadModelFromMianModel]];
    }
    
    [cell setNeedsLayout];
    
    if (_isClickSlideBar) { //通过点击SlideBar切换页面 layoutSubviews
        [cell layoutSubviews];
    }
    _isClickSlideBar = NO;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[HBSlidePageCell class]]) {
        HBSlidePageCell *sCell = (HBSlidePageCell *)cell;
        if (sCell.controller) {
            [sCell.controller viewWillDisappear:YES];
            [sCell.controller viewDidDisappear:YES];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[HBSlidePageCell class]]) {
        HBSlidePageCell *sCell = (HBSlidePageCell *)cell;
        if (sCell.controller) {
            [sCell.controller viewWillAppear:YES];
            [sCell.controller viewDidAppear:YES];
        }
    }
}

#pragma mark - UIScrollViewDelegate

/**
 * 子类重写 UIScrollViewDelegate 需要super方法
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint tempPoint = CGPointMake(scrollView.contentOffset.x, 0);
    NSIndexPath *indexPath = [self.mainColllectionView indexPathForItemAtPoint:tempPoint];
    if (_slideBar) {
        [self pageIndex:indexPath.row]; //确保self.page 正确
        [self.slideBar selectSlideBarItemAtIndex:indexPath.row];
    }
}
/*
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGPoint tempPoint = CGPointMake(scrollView.contentOffset.x, 0);
    NSIndexPath *indexPath = [self.mainColllectionView indexPathForItemAtPoint:tempPoint];
    HBSlidePageCell *cell = (HBSlidePageCell *)[self.mainColllectionView cellForItemAtIndexPath:indexPath];
    if (cell.controller.tableView.contentOffset.y > 0) {
        for (HBSlidePageModel *item in self.model.items) {
            if (item.pageIndex == cell.controller.pageIndex) {
                item.contentOffsetY = cell.controller.tableView.contentOffset.y;
                break;
            }
        }
    }
}
*/

/**
 * 设置controller初始化参数, 在子类重写
 */
- (NSDictionary *)controllersInitialQuary {
    if (self.tabItems.count <= 0) {
        return nil;
    }
    return nil;
}

/**
 * 设置Cell类, 在子类重写
 */
- (Class)cellClass {
    return [HBSlidePageCell class];
}

- (HBSlidePageModel *)model {
    if (!_model) {
        _model = [[HBSlidePageModel alloc] init];
        _model.pageIndex = 0;
    }
    return _model;
}

- (void)pageIndex:(NSInteger)index {
    self.pageIndex = index;
    self.model.pageIndex = index;
}

- (HBSlidePageModel *)reloadModelFromMianModel {
    if (self.model.items.count <= 0) {
        return nil;
    }
    for (HBSlidePageModel *item in self.model.items) {
        if (![item isKindOfClass:[HBSlidePageModel class]]) {
            return nil;
        }
        
        NSInteger pageIndex = item.pageIndex;
        
        if (pageIndex == self.pageIndex) {
            return item;
        }
    }
    return nil;
}

- (void)layoutCellSubviews:(NSInteger)pageIndex {
    NSIndexPath *path = [NSIndexPath indexPathForRow:pageIndex inSection:0];
    HBSlidePageCell *cell = (HBSlidePageCell *)[self.mainColllectionView cellForItemAtIndexPath:path];
    if (cell) {
        [cell layoutSubviews];
    }
}

/**
 * 获取collectionView中当前controller
 */
- (HBViewController *)getCurrentCellController {
    NSArray *array = self.mainColllectionView.indexPathsForVisibleItems;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if ([array count] == 1) {
        indexPath = [array lastObject];
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    HBSlidePageCell *cell = (HBSlidePageCell *)[self.mainColllectionView cellForItemAtIndexPath:path];
    if (cell) {
        if (cell.controller) {
            return cell.controller;
        }
    }
    return nil;
}

/**
 * 滑动到某个tab
 */
- (void)slideToTabWithIndex:(NSInteger)index {
    if (index < self.tabItems.count) {
        [self.mainColllectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        if (_slideBar) {
            [self.slideBar selectSlideBarItemAtIndex:index];       
        }
    }
}

#pragma mark - HBSlidePageDelegate

- (void)updatePageModel:(HBSlidePageModel *)model {
    
    if (!model || ![model isKindOfClass:[HBSlidePageModel class]]) {
        return;
    }
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
    for (HBSlidePageModel *item in self.model.items) {
        if (![item isKindOfClass:[HBSlidePageModel class]]) {
            break;
        }
        if (item.pageIndex == model.pageIndex) {
            [tempArray addObject:item];
            break;
        }
    }
    [self.model.items removeObjectsInArray:tempArray];
    [self.model.items addObject:model];
}

- (void)updateContentOffset:(CGFloat)contentOffsetY{
    for (NSObject *obj in self.model.items) {
        if ([obj isKindOfClass:[HBSlidePageModel class]]) {
            HBSlidePageModel *item = (HBSlidePageModel *)obj;
            if (item.pageIndex == self.pageIndex) {
                item.contentOffsetY = contentOffsetY;
            }
        }
    }
}

/**
 * 根据需要在子类重写
 */
- (void)scrollWithContentOffsetY:(CGFloat)contentOffsetY offset:(CGFloat)offset {
    /* eg
    // offset 1 下滑   0 上滑
    CGFloat offsetHeight = self.heardView.height - self.slideBar.height;
    if (offset < 1) { //上滑
        if (self.heardView.top > - offsetHeight) {
            [self setSlideBarTop:offsetHeight];
        }
    } else { //下滑
        if (contentOffsetY < 44) { //contentOffsetY < offsetHeight
            if (self.heardView.top < 0) {
                [self setSlideBarTop:0];
            }
        }
    }
    */
}

/*
- (void)setSlideBarTop:(CGFloat)contentOffsetY {
    [UIView animateWithDuration:0.4 animations:^{
        self.heardView.top = - contentOffsetY;
        self.mainColllectionView.top = self.heardView.height - contentOffsetY;
    } completion:^(BOOL finished) {
        
    }];
    
    float durtion = contentOffsetY > 0 ? 0 : 0.3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mainColllectionView.height = (self.view.height - self.heardView.height) + contentOffsetY;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向
        flowLayout.itemSize = CGSizeMake(self.view.width, self.mainColllectionView.height);
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing = 0.0;
        self.mainColllectionView.collectionViewLayout = flowLayout;
    });
}
*/

/**
 *取消controller所有键盘
 */
- (void)dismissAllVCKeyBoard {
    [self.mainColllectionView endEditing:YES];
}

- (void)cellControllerViewAppear{
    UIViewController *controller = [self getCurrentCellController];
    if (controller) {
        [controller viewWillAppear:YES];
        [controller viewDidAppear:YES];
    }
    
//    NSIndexPath *path = [NSIndexPath indexPathForRow:self.pageIndex inSection:0];
//    HBSlidePageCell *cell = (HBSlidePageCell *)[self.mainColllectionView cellForItemAtIndexPath:path];
//    if (cell) {
//        if (cell.controller) {
//            [cell.controller viewWillAppear:YES];
//            [cell.controller viewDidAppear:YES];
//        }
//    }
}

- (void)cellControllerViewDisAppear{
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.pageIndex inSection:0];
    HBSlidePageCell *cell = (HBSlidePageCell *)[self.mainColllectionView cellForItemAtIndexPath:path];
    if (cell) {
        if (cell.controller) {
            [cell.controller viewWillDisappear:YES];
            [cell.controller viewDidDisappear:YES];
        }
    }
}

+ (NSString *)className:(Class)aClass {
    const char *cName = object_getClassName(aClass);
    NSString *sName = [[NSString alloc] initWithBytesNoCopy:(char *)cName
                                                     length:strlen(cName)
                                                   encoding:NSASCIIStringEncoding
                                               freeWhenDone:NO];
    return sName;
}



@end
