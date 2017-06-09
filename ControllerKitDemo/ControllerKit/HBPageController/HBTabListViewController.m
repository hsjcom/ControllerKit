//
//  HBTabListViewController.m
//  TaQu
//
//  Created by Soldier on 16/7/28.
//  Copyright © 2016年 厦门海豹信息技术. All rights reserved.
//

#import "HBTabListViewController.h"
#import "ForumListModel.h"

@interface HBTabListViewController ()

@end




@implementation HBTabListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tabbar

- (FDSlideBar *)slideBar {
    if (!_slideBar) {
        _slideBar = [[FDSlideBar alloc] initWithFrame:[self slideBarFrame]];
        _slideBar.backgroundColor = [UIColor whiteColor];
        _slideBar.itemColor = COLOR_TEXT_2;
        _slideBar.itemSelectedColor = COLOR_TEXT_1;
        _slideBar.sliderColor = RGBCOLOR(255, 200, 17);
        _slideBar.sliderWidth = 35;
        WS(weakSelf);
        [_slideBar slideBarItemSelectedCallback:^(NSUInteger idx) {
            [weakSelf pageIndex:idx];
            [weakSelf clickTapWithIndex:idx];
        }];
        [self.view addSubview:_slideBar];
        
        UIView *liner = [[UIView alloc] initWithFrame:CGRectMake(0, _slideBar.height - 0.5, _slideBar.width, 0.5)];
        liner.backgroundColor = COLOR_LINE_2;
        [_slideBar addSubview:liner];
    }
    return _slideBar;
}

- (CGRect)slideBarFrame {
    return CGRectMake(0, 0, UI_SCREEN_WIDTH, 40);
}

- (void)setupSlideBarTabs:(NSArray <HBSlideTabItem *> *)tabItems {
    NSArray *tabTitles = [tabItems valueForKeyPath:@"tabName"];
    _slideBar.itemsTitle = tabTitles;
}

- (void)setTabItems:(NSMutableArray *)tabItems {
    if (!_tabItems) {
        _tabItems = [NSMutableArray new];
    }
    if (tabItems.count <= 0) {
        return;
    }
    
    _tabItems = tabItems;
    
    [self setupSlideBarTabs:_tabItems];
    
    //这里设置生效
    _slideBar.itemColor = COLOR_TEXT_2;
    _slideBar.itemSelectedColor = COLOR_TEXT_1;
}

- (void)clickTapWithIndex:(NSInteger)index {
    [self reloadDataMode];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.slideBar.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.slideBar;
}

#pragma mark - pageModel

- (HBSlidePageModel *)pageModel {
    if (!_pageModel) {
        _pageModel = [[HBSlidePageModel alloc] init];
        _pageModel.pageIndex = 0;
    }
    return _pageModel;
}

/**
 * 根据子类的数据类型 重写
 * 多次调用
 * 初始化[self pageIndex:0];  在初始化_slideBar数据后，create model 之前初始化
 */
- (void)pageIndex:(NSInteger)index {
    self.pageIndex = index;
    self.pageModel.pageIndex = index;
    self.selectTabItem = [self getTabItem];
    
    //相应的子类数据model
//    self.model.pageIndex = index;
}

- (HBSlidePageModel *)getReloadModelFromPageModel {
    if (self.pageModel.items.count <= 0) {
        return nil;
    }
    
    for (HBSlidePageModel *item in self.pageModel.items) {
        if (item.pageIndex == self.pageIndex) {
            return item;
        }
    }
    return nil;
}

/**
 * 更新page model
 * 在 createDataSource or onDataUpdated 调用
 */
- (void)updatePageModel {
    id obj = [self createUpdatePageModel];
    if (!obj) {
        return;
    }
    if (![obj isKindOfClass:[HBSlidePageModel class]]) {
        return;
    }
    
    HBSlidePageModel *model = (HBSlidePageModel *)obj;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
    
    for (HBSlidePageModel *item in self.pageModel.items) {
        if (item.pageIndex == model.pageIndex) {
            [tempArray addObject:item];
            break;
        }
    }
    [self.pageModel.items removeObjectsInArray:tempArray];
    [self.pageModel.items addObject:model];
}

/**
 * 生成用来存储的model,在子类重写
 * 勿直接用子类的self.model,因为保存为统一指针，会被篡改
 * 需要根据子类数据model的属性一一赋值
 */
- (id)createUpdatePageModel {
    /*
     基础属性
    HBSlidePageModel *model = [[HBSlidePageModel alloc] init];
    model.items = [NSMutableArray arrayWithArray:self.model.items];
    model.pageIndex = self.pageIndex;
    model.contentOffsetY = self.model.contentOffsetY;
    
    model.page = self.model.page;
    model.newItemsCount = self.model.newItemsCount;
    model.modelController = self.model.modelController;
    model.loadType = self.model.loadType;
     
    & 其他属性
     
    */
    
    return nil;
}

- (void)updateContentOffset:(CGFloat)contentOffsetY{
    for (HBSlidePageModel *item in self.pageModel.items) {
        if (item.pageIndex == self.pageIndex) {
            item.contentOffsetY = contentOffsetY;
        }
    }
}

- (void)reloadDataMode{
    HBSlidePageModel *model = [self getReloadModelFromPageModel];

    if (!model) {
        //调整 contentOffset.y
        [self adjustTableViewContentOffsetY:0];
        
        [self refreshForNewData];
        
        return;
    }
    
    [self reloadModel:model];
    self.page = model.page > 0 ? model.page : 1;
    
    [self onDataUpdated];
    
    //调整 contentOffset.y
    [self adjustTableViewContentOffsetY:model.contentOffsetY];
}

/**
 * reload model 数据，根据子类的数据类型 重写
 */
- (void)reloadModel:(HBSlidePageModel *)model {
    if (!model) {
        return;
    }
    /**
     * eg
     
    if ([model isKindOfClass:[ForumListModel class]]) {
        ForumListModel *fmodel = (ForumListModel *)model;
        self.model = fmodel;
    }
     
     */
}

/**
 * 获取TabItem数据
 */
- (HBSlideTabItem *)getTabItem {
    if (self.tabItems.count <= 0) {
        return nil;
    }
    
    //可根据需要在子类重写
    HBSlideTabItem *tabItem = nil;
    if (self.tabItems.count > self.pageIndex) {
        tabItem = [self.tabItems objectAtIndex:self.pageIndex];
    } else {
        tabItem = [self.tabItems objectAtIndex:0];
    }
    return tabItem;
}

#pragma mark - UIScrollViewDelegate

/**
 * 子类重写需要调父类方法
 */
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (scrollView && scrollView == self.tableView) {
//        [self updateContentOffset:scrollView.contentOffset.y];
//    }
//}

/**
* 子类重写需要调父类方法
*/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView && scrollView == self.tableView) {
        [self updateContentOffset:scrollView.contentOffset.y];
    }
}

/**
 * 滑动到某个tab
 */
- (void)slideToTabWithIndex:(NSInteger)index {
    if (index < self.tabItems.count) {
        if (_slideBar) {
            [self.slideBar selectSlideBarItemAtIndex:index];
        }
    }
}

/**
 * 调整 tableview contentOffset.y
 * 交互规则与微博个人主页相似
 */
- (void)adjustTableViewContentOffsetY:(CGFloat)originalY {
    CGFloat offsetY = originalY;
    if (offsetY < 0) {
        return;
    }
    CGFloat height = self.tableView.tableHeaderView ? self.tableView.tableHeaderView.height : 0;
    
    if (self.tableView.contentOffset.y >= height) {
        offsetY = height;
    }
    if (originalY > height) {
        offsetY = originalY;
    }
    if (self.tableView.contentOffset.y <= height - 20) {
        offsetY = self.tableView.contentOffset.y;
    }
    
    self.tableView.contentOffset = CGPointMake(0, offsetY);
}

/**
 * 调整 tableview contentSize.height
 * 当存在tableHeaderView时，self.tableView.contentSize.height < self.view.height + height的情况时
 * 根据需要看是否调用，建议在 onDataUpdated 最后调用
 */
- (void)adjustTableViewContentSizeHeight {
    //调整 contentSize.height
    if (self.tableView.tableHeaderView) {
        CGFloat height = self.tableView.tableHeaderView.height;
        if (self.tableView.contentSize.height < self.view.height + height) {
            self.tableView.contentSize = CGSizeMake(self.tableView.width, self.view.height + height);
        }
    }
}


@end
