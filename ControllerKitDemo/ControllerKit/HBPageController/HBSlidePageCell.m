//
//  HBSlidePageCell.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBSlidePageCell.h"
#import "HBSlidePageItemController.h"

@implementation HBSlidePageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];// COLOR_GRAY_BG;
        self.backgroundColor = [UIColor clearColor];//COLOR_GRAY_BG;
    }
    return self;
}

/**
 * 子类重写
 */
- (void)initWithQuery:(NSDictionary *)query
             delegate:(id)delegate
                index:(NSInteger)index {
    if (!_controller) {
        
    } else {
        [self.controller.view removeFromSuperview];
        _controller = nil;
    }
    
    HBSlidePageItemController *vc = [[HBSlidePageItemController alloc] initWithQuery:query];
    vc.view.frame = [self viewControllerFrame];
    vc.tableView.frame = [self tableViewFrame];
    [self.contentView addSubview:vc.view];
    self.controller = vc;
    
    self.controller.spDelegate = delegate;
    [self.controller initialPageIndex:index];
    [self.controller initialQuery:query];
}

- (void)reloadDataWithMode:(HBSlidePageModel *)model{
    if (!model) {
        /**
         * 先使用缓存填充
         * 需要的在子类打开
         */
//        [self.controller loadDataFromCache];
        [self.controller refreshForNewData];
        
        return;
    }
    [self.controller reloadModel:model];
    self.controller.page = model.page > 0 ? model.page : 1;
    [self.controller onDataUpdated];
    
    if (model.contentOffsetY >= 0) {
        self.controller.tableView.contentOffset = CGPointMake(0, model.contentOffsetY);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.controller.view.frame = [self viewControllerFrame];
    self.controller.tableView.frame = [self tableViewFrame];
}

- (CGRect)viewControllerFrame {
    return CGRectMake(0, 0, self.width, self.height);
}

- (CGRect)tableViewFrame {
    return CGRectMake(0, 0, self.width, self.height);
}

@end
