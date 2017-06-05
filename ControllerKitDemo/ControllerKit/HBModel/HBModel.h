//
//  HBModel.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBModelViewController.h"

/**
 HBModel
 数据model
 */
@interface HBModel : NSObject

/**
 items model items 
 NSMutableArray <HBLayout *> *items
 */
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) NSUInteger newItemsCount;
@property (nonatomic, weak) HBModelViewController *modelController;
@property (nonatomic) PullLoadType loadType;

@end
