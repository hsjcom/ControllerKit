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
@property(nonatomic, assign) BOOL loadMoreEnable;

@end
