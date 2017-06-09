//
//  HBTableViewCell.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/6.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBTableViewCell : UITableViewCell

@property (nonatomic, strong) id object;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;

@end
