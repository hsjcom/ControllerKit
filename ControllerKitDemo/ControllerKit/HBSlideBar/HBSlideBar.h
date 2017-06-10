//
//  HBSlideBar.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HBSlideBarItemSelectedCallback)(NSUInteger idx);

@interface HBSlideBar : UIView

@property (copy, nonatomic) NSArray *itemsTitle;

@property (strong, nonatomic) UIColor *itemColor;

@property (strong, nonatomic) UIColor *itemSelectedColor;

@property (strong, nonatomic) UIColor *sliderColor;

@property (strong, nonatomic) UIScrollView *scrollView;

// 是否开启居中样式 default NO 注：内部的item总长度必须小于scrollView的长度才有效
@property (nonatomic, assign) BOOL middleStyle;

// 每个item固定的宽度，默认是根据字的长度自适应
@property (nonatomic, assign) CGFloat fixedItemWidth;

// 每个item的间距，default 0
@property (nonatomic, assign) CGFloat itemPadding;

// 下划线的高度 默认见.m 里面的宏SLIDER_VIEW_HEIGHT
@property (nonatomic, assign) CGFloat sliderHeight;

// 下划线的固定宽度 默认见.m 里面的宏SLIDER_VIEW_WIDTH，如果要自适应item的宽度（即fixedWidth），该值设为-1即可0为不显示
@property (nonatomic, assign) CGFloat sliderWidth;

// 标题的字体，默认见FDSlideBarItem里面的宏
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *titleSelectedFont;

// 粗体 default = NO；
@property (nonatomic, assign) BOOL isBoldFont;

// 关闭下划线滑动动画 , 默认有动画
@property (nonatomic, assign) BOOL closeAnimation;

// 隐藏下划线 default = NO
@property (nonatomic, assign) BOOL hideSlideView;

// item 宽度Margin，default 14 * 2.
@property (nonatomic, assign) CGFloat horizontalMargin;

//item 选中颜色，default clearColor.
@property (nonatomic, strong) UIColor *itemBgSelectColor;

//item 背景颜色，default clearColor
@property (nonatomic, strong) UIColor *itemBackgroundColor;

@property (strong, nonatomic) UIView *sliderView;

// Add the callback deal when a slide bar item be selected
- (void)slideBarItemSelectedCallback:(HBSlideBarItemSelectedCallback)callback;

// Set the slide bar item at index to be selected
- (void)selectSlideBarItemAtIndex:(NSUInteger)index;

// 没有左右两边的渐变图层
- (instancetype)initWithFrameWithoutFadeLayer:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame showFadeLayer:(BOOL)showFadeLayer showLiner:(BOOL)showLiner;

@end
