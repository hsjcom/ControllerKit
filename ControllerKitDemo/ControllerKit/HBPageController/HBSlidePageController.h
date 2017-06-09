//
//  HBSlidePageController.h
//  TaQu
//
//  Created by Soldier on 16/4/1.
//  Copyright © 2016年 厦门海豹信息技术. All rights reserved.
//

#import "HBModelViewController.h"
#import "HBSlidePageModel.h"
#import "FDSlideBar.h"
#import "HBSlideTabItem.h"


@protocol HBSlidePageDelegate <NSObject>

@required

- (void)updatePageModel:(HBSlidePageModel *)model;

- (void)updateContentOffset:(CGFloat)contentOffsetY;

@optional

- (void)scrollWithContentOffsetY:(CGFloat)contentOffsetY offset:(CGFloat)offset; // offset 其它参数

- (void)itemControllBeginPullDownRefreshing; //tab Controller 下拉刷新回调

- (void)scrollViewDidScrollWithContentOffsetY:(CGFloat)contentOffsetY offset:(CGFloat)offset;


@end




/**
 * 横向滑动分页 HBSlidePageController
 * midel—>HBSlidePageModel cell->HBSlidePageCell
 */

@interface HBSlidePageController : HBModelViewController<UICollectionViewDataSource, UICollectionViewDelegate, HBSlidePageDelegate> {
    NSMutableArray *_tabItems;
    FDSlideBar *_slideBar;
}

@property (nonatomic, strong) UICollectionView *mainColllectionView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) HBSlidePageModel *model;
@property (nonatomic, strong) FDSlideBar *slideBar;
@property (nonatomic, strong) NSMutableArray *tabItems;
@property (nonatomic, assign) BOOL isClickSlideBar; //通过点击切换页面

- (CGRect)slideBarFrame;

- (CGRect)colllectionViewFrame;

/**
 * 设置controller初始化参数, 在子类重写
 */
- (NSDictionary *)controllersInitialQuary;

/**
 * 设置Cell类, 在子类重写
 */
- (Class)cellClass;

/**
 *取消controller所有键盘
 */
- (void)dismissAllVCKeyBoard;

- (void)cellControllerViewAppear;

- (void)cellControllerViewDisAppear;

/**
 * 获取collectionView中当前controller
 */
- (HBViewController *)getCurrentCellController;

/**
 * 滑动到某个tab
 */
- (void)slideToTabWithIndex:(NSInteger)index;

/**
 * 点击某个tab的回调
 */
- (void)clickTapWithIndex:(NSInteger)index;

- (void)pageIndex:(NSInteger)index;

@end
