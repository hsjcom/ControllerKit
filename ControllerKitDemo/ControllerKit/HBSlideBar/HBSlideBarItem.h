//
//  HBSlideBarItem.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HBSlideBarItem;

@protocol HBSlideBarItemDelegate <NSObject>

- (void)slideBarItemSelected:(HBSlideBarItem *)item;

@end




@interface HBSlideBarItem : UIView

@property (assign, nonatomic) BOOL selected;
@property (weak, nonatomic) id<HBSlideBarItemDelegate> delegate;
//粗体 default = NO；
@property (nonatomic, assign) BOOL isBoldFont;
//item 选中颜色，default clearColor.
@property (nonatomic, strong) UIColor *itemBgSelectColor;
//item 背景颜色，default clearColor.
@property (nonatomic, strong) UIColor *itemBackgroundColor;

- (void)setItemTitle:(NSString *)title;

- (void)setItemTitleFont:(CGFloat)fontSize;

- (void)setItemTitleColor:(UIColor *)color;

- (void)setItemSelectedTileFont:(CGFloat)fontSize;

- (void)setItemSelectedTitleColor:(UIColor *)color;

+ (CGFloat)widthForTitle:(NSString *)title font:(UIFont *)font horizontalMargin:(CGFloat)horizontalMargin;

@end
