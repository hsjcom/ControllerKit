//
//  HBTableViewDataSource.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/5.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBTableViewDataSource.h"
#import <objc/runtime.h>
#import "HBTableViewCell.h"

@implementation HBTableViewDataSource

- (void)dealloc {
    [self setItems:nil];
}

- (id)initWithItems:(NSArray *)items {
    self = [self init];
    if (self) {
        self.items = [NSMutableArray arrayWithArray:items];
    }
    
    return self;
}

- (id)initWithSectionsItems:(NSArray *)items {
    self = [self init];
    if (self) {
        self.sectionsItems = [NSMutableArray arrayWithArray:items];
    }
    
    return self;
}

+ (HBTableViewDataSource *)dataSourceWithObjects:(id)object, ... {
    NSMutableArray *items = [NSMutableArray array];
    va_list ap;
    va_start(ap, object);
    while (object) {
        [items addObject:object];
        object = va_arg(ap, id);
    }
    va_end(ap);
    
    return [[self alloc] initWithItems:items];
}

/**
 * numberOfSectionsInTableView = 1
 */
+ (HBTableViewDataSource *)dataSourceWithItems:(NSMutableArray *)items {
    return [[self alloc] initWithItems:items];
}

/**
 * numberOfSectionsInTableView > 1
 */
+ (HBTableViewDataSource *)dataSourceWithSectionsItems:(NSMutableArray *)items {
    return [[self alloc] initWithSectionsItems:items];
}

+ (void)addToArray:(NSMutableArray *)array value:(NSObject *)value{
    if (!array || ![array isKindOfClass:[NSMutableArray class]]) {
        return;
    }
    if (!value) {
        return;
    }
    [array addObject:value];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.sectionsItems.count > 0) {
        return self.sectionsItems.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sectionsItems.count > 0) {
        /**
         *因数据结构差异，需在子类重写
         * eg: CategoryItem *item = [self.sectionsItems objectAtIndex:section];
         return [item.dataArray count];
         */
        
        return 5;
    } else {
        return self.items.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    const char *className = class_getName(cellClass);
    NSString *identifier = [[NSString alloc] initWithBytesNoCopy:(char *) className
                                                          length:strlen(className)
                                                        encoding:NSASCIIStringEncoding freeWhenDone:NO];
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:identifier];
    }
    
    if ([cell isKindOfClass:[HBTableViewCell class]]) {
        [(HBTableViewCell *) cell setObject:object];
    }
    
    // 目前没有用到
    //    [self tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark

#pragma mark - HBTableViewDataSource

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath {
}

- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionsItems.count > 0) {
        if (indexPath.section < self.sectionsItems.count) {
            /**
             *因数据结构差异，需在子类重写
             * eg: id obj = [self.sectionsItems objectAtIndex:(NSUInteger) indexPath.section];
             if ([obj isKindOfClass:[CategoryItem class]]) {
             CategoryItem *item = (CategoryItem *)obj;
             if (indexPath.row < item.dataArray.count) {
             return [item.dataArray objectAtIndex:(NSUInteger) indexPath.row];
             }
             }
             */
            
            return nil;
        } else {
            return nil;
        }
    }
    
    else {
        if (indexPath.row < self.items.count) {
            return [self.items objectAtIndex:(NSUInteger) indexPath.row];
        } else {
            return nil;
        }
    }
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
    return [HBTableViewCell class];
}

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object {
    NSUInteger objectIndex = [self.items indexOfObject:object];
    if (objectIndex != NSNotFound) {
        return [NSIndexPath indexPathForRow:objectIndex inSection:0];
    }
    return nil;
}

@end
