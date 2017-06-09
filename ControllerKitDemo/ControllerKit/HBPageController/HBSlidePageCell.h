//
//  HBSlidePageCell.h
//  TaQu
//
//  Created by Soldier on 16/3/30.
//  Copyright © 2016年 厦门海豹信息技术. All rights reserved.
//

#import "HBCollectionViewCell.h"
#import "HBSlidePageItemController.h"

@interface HBSlidePageCell : UICollectionViewCell {
    HBSlidePageItemController *_controller;
}

@property (nonatomic, strong) NSDictionary *query;
@property (nonatomic, strong) HBSlidePageItemController *controller;

- (void)initWithQuery:(NSDictionary *)query
             delegate:(id)delegate
                index:(NSInteger)index;

- (void)reloadDataWithMode:(HBSlidePageModel *)model;

- (CGRect)viewControllerFrame;

- (CGRect)tableViewFrame;

@end
