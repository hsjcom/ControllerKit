//
//  ViewController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/2.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"


@interface DemoDataSource : HBTableViewDataSource

@end




@implementation DemoDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
    if ([object isKindOfClass:[DemoItem class]]) {
        return [DemoCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}

@end




@interface ViewController ()

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ControllerKit";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self autoPullDown];
}

- (void)createDataSource {
    self.dataSource = [DemoDataSource dataSourceWithItems:self.items];
}

- (void)loadNewData {
    self.pullLoadType = PullDownRefresh;
    [self createData];
}

- (void)loadMoreData {
    self.pullLoadType = PullUpLoadMore;
    [self createData];
}

- (void)createData {
    if (self.pullLoadType == PullDownRefresh) {
        [self.items removeAllObjects];
    }
    
    for (int i = 0; i < 10; i++) {
        DemoItem *item = [[DemoItem alloc] init];
        item.title = [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)];
        
        if (self.pullLoadType == PullDownRefresh) {
            [self.items insertObject:item atIndex:0];
        } else {
            [self.items addObject:item];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self onDataUpdated];
    });
}


@end
