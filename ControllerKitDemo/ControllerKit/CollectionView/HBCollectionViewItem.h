//
//  HBCollectionViewItem.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBCollectionViewItem : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) SEL selector;

@end
