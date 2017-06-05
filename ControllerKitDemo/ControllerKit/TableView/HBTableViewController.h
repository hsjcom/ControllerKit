//
//  HBTableViewController.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBModelViewController.h"
#import "HBTableViewDataSource.h"

@interface HBTableViewController : HBModelViewController <UITableViewDelegate>

@property(nonatomic, strong) id <HBTableViewDataSource> dataSource;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) PullLoadType pullLoadType;
@property(nonatomic, assign) NSInteger newItemsCount;
@property(nonatomic, assign) int page;
@property(nonatomic, assign) BOOL loadMoreEnable;
@property(nonatomic, assign) BOOL loadRefreshEnable;

- (UITableViewStyle)tableViewStyle;

- (CGRect)tableViewFrame;

/**
 reloadData [self.tableView reloadData];
 */
- (void)reloadData;

@end
