//
//  HBViewController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/2.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBViewController.h"

@interface HBViewController ()

@end

@implementation HBViewController

- (void)dealloc {
    
}

- (id)initWithQuery:(NSDictionary *)query {
    self = [super init];
    if (self) {
        if (query) {
            self.query = query;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigationBar];
    self.view.backgroundColor = [self backgroundColor];
}

#pragma mark - View

- (UIColor *)backgroundColor {
    return COLOR_BG;
}

- (void)configNavigationBar  {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [navBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:RGBCOLOR(40, 33, 33), NSForegroundColorAttributeName, shadow, NSShadowAttributeName,
      [UIFont systemFontOfSize:17], NSFontAttributeName,
      nil]];
}

/**
 自定义返回按钮
 */
- (void)constructBackBtn{
    //root controller 不出现 返回按钮
    if ([self isRootController]){
        return;
    }
    
    self.navigationItem.backBarButtonItem.enabled = NO;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"navBackIndicatorImg"] forState:UIControlStateNormal];
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 52, 44);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
}

/**
 导航栏左边按钮
 */
- (void)addNavLeftBtn:(UIView *)btn {
    if (!btn) {
        return;
    }
    
    btn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

/**
 导航栏右边按钮
 */
- (void)addNavRightBtn:(UIView *)btn {
    if (!btn) {
        return;
    }
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - Func

- (BOOL)isRootController {
    return NO;
}

- (BOOL)canDragBack {
    return YES;
}

- (BOOL)shouldHideNavBar {
    return NO;
}

- (BOOL)fd_interactivePopDisabled {
    return ![self canDragBack];
}

- (BOOL)fd_prefersNavigationBarHidden {
    return [self shouldHideNavBar];
}

- (void)backView {
    [self backView:YES];
}

- (void)backView:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}

@end
