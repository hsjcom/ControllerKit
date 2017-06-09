//
//  HBCollectionViewDataSource.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBCollectionViewLayout.h"

@class HBCollectionViewHeaderView;
@class HBCollectionViewFooterView;


@protocol HBCollectionViewDataSource <UICollectionViewDataSource>

- (id)collectionView:(UICollectionView *)collectionView objectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (Class)collectionView:(UICollectionView *)collectionView cellClassForObject:(id)object;

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForObject:(id)object;

@end




@interface HBCollectionViewDataSource : NSObject<HBCollectionViewDataSource, UICollectionViewDelegateFlowLayout, HBCollectionViewLayoutDelegate>{
    NSMutableDictionary *_headerViews;
    NSMutableDictionary *_footerViews;
}

@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) NSMutableArray *mutiItems;


+ (HBCollectionViewDataSource *)dataSourceWithItems:(NSMutableArray *)items;

//用于多Section情况
+ (HBCollectionViewDataSource *)dataSourceWithMutiItems:(NSMutableArray *)items;


#pragma mark - Header

//header头视图
- (HBCollectionViewHeaderView *)headerView;

//section对应的header头视图
- (HBCollectionViewHeaderView *)headerViewForSection:(NSUInteger)section;

//header头视图
- (HBCollectionViewHeaderView *)constructHeaderView:(UICollectionView *)collectionView;

//section对应的header头视图
- (HBCollectionViewHeaderView *)constructHeaderViewForSection:(NSUInteger)section
                                                      andView:(UICollectionView *)collectionView;

//header头的高度 
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
 heightForHeaderInSection:(NSInteger)section;

- (Class)headerClassForSection:(NSUInteger)section collectionView:(UICollectionView *)collectionView ;

#pragma mark - Footer

//footer视图
- (HBCollectionViewFooterView *)footerView;

//section对应的footer视图
- (HBCollectionViewFooterView *)footerViewForSection:(NSUInteger)section;

//footer视图
- (HBCollectionViewFooterView *)constructFooterView:(UICollectionView *)collectionView;

//section对应的footer视图
- (HBCollectionViewFooterView *)constructFooterViewForSection:(NSUInteger)section
                                                      andView:(UICollectionView *)collectionView;

//footer的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
 heightForFooterInSection:(NSInteger)section;


@end
