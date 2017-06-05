//
//  HBViewController.h
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/2.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBViewController : UIViewController

- (id)initWithQuery:(NSDictionary *)query;

/**
 Push Controller 参数
 */
@property(nonatomic, strong) NSDictionary *query;

/**
 是否主Controller 
 */
- (BOOL)isRootController;

/**
 右滑返回 default YES
 */
- (BOOL)canDragBack;

/**
 是否隐藏导航栏 default NO
 */
- (BOOL)shouldHideNavBar;

- (void)backView;

- (void)backView:(BOOL)animated;

- (UIColor *)backgroundColor;
    
/**
 导航栏左边按钮
 */
- (void)addNavLeftBtn:(UIView *)btn;

/**
 导航栏右边按钮
 */
- (void)addNavRightBtn:(UIView *)btn;


@end
