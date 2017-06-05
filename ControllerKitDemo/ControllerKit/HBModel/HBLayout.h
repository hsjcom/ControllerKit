//
//  HBLayout.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * UITableView UICollectionView 数据model item(NSObject)父类
 * cellHeight
 */

@interface HBLayout : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat textHeight; //缓存文本行高，处理较为复杂的emoji或特殊字符文本

/**
 * 数据变化切记重置高度!
 */
- (void)resetCellHeight;

@end
