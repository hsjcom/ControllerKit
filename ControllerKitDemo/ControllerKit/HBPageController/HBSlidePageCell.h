//
//  HBSlidePageCell.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBCollectionViewCell.h"
#import "HBSlidePageItemController.h"
#import "HBSlidePageModel.h"

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
