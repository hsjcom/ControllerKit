//
//  HBCollectionViewCell.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HBCollectionViewCell : UICollectionViewCell

- (id)object;

- (void)setObject:(id)object;

+ (CGFloat)collectionView:(UICollectionView *)collectionView rowHeightForObject:(id)object;

- (void)gridClick;

//设置点按效果的
- (void)setCoverBtnEnable;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
