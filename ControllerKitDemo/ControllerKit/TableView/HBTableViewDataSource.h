//
//  HBTableViewDataSource.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HBTableViewDataSource <UITableViewDataSource>

- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object;

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object;

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath;

@end





@interface HBTableViewDataSource : NSObject <HBTableViewDataSource>


@end
