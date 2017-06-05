//
//  HBTableViewController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBTableViewController.h"

@interface HBTableViewController ()

@end

@implementation HBTableViewController

- (void)dealloc {
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
    _dataSource = nil;
    _tableView = nil;
}

- (id)initWithQuery:(NSDictionary *)query {
    self = [super initWithQuery:query];
    if (self) {
        self.page = 1;
        self.items = [NSMutableArray arrayWithCapacity:0];
        self.pullLoadType = PullDefault;
        
        _loadMoreEnable = YES;
        _loadRefreshEnable = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
}

#pragma mark - TableView

- (UITableView *)tableView {
    if (nil == _tableView){
        _tableView = [[UITableView alloc] initWithFrame:[self tableViewFrame] style:[self tableViewStyle]];
        _tableView.backgroundColor = [self backgroundColor];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}

- (CGRect)tableViewFrame {
    CGRect rect = self.view.bounds;
    return rect;
}

- (void)setDataSource:(id <HBTableViewDataSource>)dataSource{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        self.tableView.dataSource = _dataSource;
        [self reloadData];
    }
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate


@end
