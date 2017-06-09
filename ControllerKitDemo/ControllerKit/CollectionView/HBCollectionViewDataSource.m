//
//  HBCollectionViewDataSource.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBCollectionViewDataSource.h"
#import "HBCollectionViewCell.h"
#import "HBCollectionViewHeaderView.h"
#import "HBCollectionViewFooterView.h"
#import <objc/runtime.h>
#import "HBLayout.h"

@implementation HBCollectionViewDataSource

- (void)dealloc {
    [self setItems:nil];
    [self setMutiItems:nil];
}

- (id)initWithItems:(NSArray *)items {
    self = [self init];
    if (self) {
        self.items = [NSMutableArray arrayWithArray:items];
        _headerViews = [NSMutableDictionary dictionary];
        _footerViews = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (id)initWithMutiItems:(NSArray *)mutiItems{
    self = [self init];
    if (self) {
        self.mutiItems = [NSMutableArray arrayWithArray:mutiItems];
        _headerViews = [NSMutableDictionary dictionary];
        _footerViews = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (HBCollectionViewDataSource *)dataSourceWithItems:(NSMutableArray *)items {
    return [[self alloc] initWithItems:items];
}

//用于多Section情况
+ (HBCollectionViewDataSource *)dataSourceWithMutiItems:(NSMutableArray *)mutiItems{
    return [[self alloc] initWithMutiItems:mutiItems];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.mutiItems){
        NSUInteger count = self.mutiItems.count;
        if (count > section) {
            NSArray *array = self.mutiItems[section];
            return array.count;
        }
    }
    else if (self.items){
        return self.items.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.mutiItems){
        return self.mutiItems.count;
    }
    else if (self.items){
        return 1;
    }
    return 0;
}

- (void)registerCellIdentifierForView:(UICollectionView *)collectionView cellClass:(Class)cellClass{
    NSString *className = [self.class className:cellClass];
    [collectionView registerClass:cellClass forCellWithReuseIdentifier:className];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self collectionView:collectionView objectForRowAtIndexPath:indexPath];
    
    Class cellClass = [self collectionView:collectionView cellClassForObject:object];
    const char *className = class_getName(cellClass);
    
    [self registerCellIdentifierForView:collectionView cellClass:cellClass];
    
    NSString *identifier = [[NSString alloc] initWithBytesNoCopy:(char *) className
                                                          length:strlen(className)
                                                        encoding:NSASCIIStringEncoding freeWhenDone:NO];
    
    UICollectionViewCell *cell = (UICollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[cellClass alloc] init];
    }
    
    if ([cell isKindOfClass:[HBCollectionViewCell class]]) {
        [(HBCollectionViewCell *) cell setObject:object];
    }
    
    [cell setNeedsLayout];
    return cell;
}

#pragma mark -


#pragma mark - HBCollectionViewDataSource

- (id)collectionView:(UICollectionView *)collectionView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (self.mutiItems) {
        if (section < self.mutiItems.count) {
            NSArray *theItems = self.mutiItems[section];
            if(row < theItems.count){
                return theItems[row];
            }
        }
    } else {
        if(row < _items.count) {
            return _items[row];
        }
    }
    return nil;
}

- (Class)collectionView:(UICollectionView *)collectionView cellClassForObject:(id)object {
    return [HBCollectionViewCell class];
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForObject:(id)object {
    if (self.mutiItems) {
        for(int i = 0; i < _mutiItems.count; i++){
            NSArray *theItems = _mutiItems[i];
            NSUInteger objectIndex = [theItems indexOfObject:object];
            if(NSNotFound != objectIndex){
                return [NSIndexPath indexPathForRow:objectIndex inSection:i];
            }
        }
    }
    else{
        NSUInteger objectIndex = [_items indexOfObject:object];
        if (objectIndex != NSNotFound) {
            return [NSIndexPath indexPathForRow:objectIndex inSection:0];
        }
    }
    return nil;
}


#pragma mark HBCollectionViewLayoutDelegate
#pragma mark - Header

//header头视图
- (HBCollectionViewHeaderView *)headerView {
    return [self headerViewForSection:0];
}

//section对应的header头视图
- (HBCollectionViewHeaderView *)headerViewForSection:(NSUInteger)section{
    NSUInteger tag = 1000 + section;
    HBCollectionViewHeaderView *view = [_headerViews objectForKey:[NSString stringWithFormat:@"%d",(int)tag]];
    return view;
}

//header头视图
- (HBCollectionViewHeaderView *)constructHeaderView:(UICollectionView *)collectionView{
    return nil;
}

//section对应的header头视图
- (HBCollectionViewHeaderView *)constructHeaderViewForSection:(NSUInteger)section
                                                      andView:(UICollectionView *)collectionView{
    return nil;
}

//header高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
 heightForHeaderInSection:(NSInteger)section{
    return 0.f;
}

#pragma mark - Footer

//footer视图
- (HBCollectionViewFooterView *)footerView{
    return [self footerViewForSection:0];
}

//section对应的footer视图
- (HBCollectionViewFooterView *)footerViewForSection:(NSUInteger)section{
    NSUInteger tag = 10000 + section;
    HBCollectionViewFooterView *view = [_footerViews objectForKey:[NSString stringWithFormat:@"%d", (int)tag]];
    return view;
}

//footer视图
- (HBCollectionViewFooterView *)constructFooterView:(UICollectionView *)collectionView{
    return nil;
}

//section对应的footer视图
- (HBCollectionViewFooterView *)constructFooterViewForSection:(NSUInteger)section
                                                      andView:(UICollectionView *)collectionView{
    return nil;
}

//footer的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
 heightForFooterInSection:(NSInteger)section{
    return 0.f;
}

- (Class)headerClassForSection:(NSUInteger)section collectionView:(UICollectionView *)collectionView {
    return [HBCollectionViewHeaderView class];
}

- (Class)footerClassForSection:(NSUInteger)section collectionView:(UICollectionView *)collectionView {
    return [HBCollectionViewFooterView class];
}

- (void)registerHeaderIdentifierForView:(UICollectionView *)collectionView
                            headerClass:(Class)headerClass{
    NSString *className = [self.class className:headerClass];
    [collectionView registerClass:headerClass
       forSupplementaryViewOfKind:HBCollectionViewHeader
              withReuseIdentifier:className];
}

- (void)registerFooterIdentifierForView:(UICollectionView *)collectionView
                            footerClass:(Class)footerClass {
    NSString *className = [self.class className:footerClass];
    [collectionView registerClass:footerClass
       forSupplementaryViewOfKind:HBCollectionViewFooter
              withReuseIdentifier:className];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:HBCollectionViewHeader]) {
        Class headerClass = [self headerClassForSection:indexPath.section collectionView:collectionView];
        NSString *className = [self.class className:headerClass];
        [self registerHeaderIdentifierForView:collectionView headerClass:headerClass];
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:className
                                                                 forIndexPath:indexPath];
        if (reusableView == nil) {
            reusableView = [[headerClass alloc] init];
        }
        
        NSUInteger tag = (1000 + indexPath.section);
        [_headerViews setObject:reusableView forKey:[NSString stringWithFormat:@"%d", (int)tag]];
        
    } else if ([kind isEqualToString:HBCollectionViewFooter]){
        Class footerClass = [self footerClassForSection:indexPath.section collectionView:collectionView];
        NSString *className = [self.class className:footerClass];
        [self registerFooterIdentifierForView:collectionView footerClass:footerClass];
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:className
                                                                 forIndexPath:indexPath];
        if (reusableView == nil) {
            reusableView = [[footerClass alloc] init];
        }
        
        NSUInteger tag = (10000 + indexPath.section);
        [_footerViews setObject:reusableView forKey:[NSString stringWithFormat:@"%d",(int)tag]];
    }
    
    return reusableView;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
         heightForSection:(NSInteger )section
             forItemIndex:(NSUInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
    id object = [self collectionView:collectionView objectForRowAtIndexPath:indexPath];
    
    CGFloat height = 0;
    /**
     * 优化cell高度计算
     * by Soldier
     */
    if ([object isKindOfClass:[HBLayout class]]) {
        HBLayout *layout = (HBLayout *)object;
        if (layout.cellHeight > 0) {
            return layout.cellHeight;
        }
        Class cellClass = [self collectionView:collectionView cellClassForObject:object];
        height = [cellClass collectionView:collectionView rowHeightForObject:object];
        layout.cellHeight = height;
        return height;
        
    } else {
        Class cellClass = [self collectionView:collectionView cellClassForObject:object];
        height = [cellClass collectionView:collectionView rowHeightForObject:object];
        return height;
    }
}

+ (void)addToArray:(NSMutableArray *)array value:(NSObject *)value {
    if (!array || ![array isKindOfClass:[NSMutableArray class]]) {
        return;
    }
    if (!value) {
        return;
    }
    [array addObject:value];
}

+ (HBCollectionViewDataSource *)dataSourceWithObjects:(id)object, ... {
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

+ (NSString *)className:(Class)aClass {
    const char *cName = object_getClassName(aClass);
    NSString *sName = [[NSString alloc] initWithBytesNoCopy:(char *)cName
                                                     length:strlen(cName)
                                                   encoding:NSASCIIStringEncoding
                                               freeWhenDone:NO];
    return sName;
}

@end
