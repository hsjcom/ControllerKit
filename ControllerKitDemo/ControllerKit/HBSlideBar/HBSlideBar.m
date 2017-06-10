//
//  HBSlideBar.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBSlideBar.h"
#import "HBSlideBarItem.h"

#define DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define DEFAULT_SLIDER_COLOR [UIColor orangeColor]
#define SLIDER_VIEW_HEIGHT 3
#define SLIDER_VIEW_WIDTH -1

@interface HBSlideBar ()<HBSlideBarItemDelegate>

@property (strong, nonatomic) NSMutableArray *items;

@property (strong, nonatomic) HBSlideBarItem *selectedItem;
@property (strong, nonatomic) HBSlideBarItemSelectedCallback callback;

@property (nonatomic, weak) UIImageView *leftImgV;
@property (nonatomic, weak) UIImageView *rightImgV;

@property (nonatomic, assign) CGFloat allWidth;

@end




@implementation HBSlideBar 

#pragma mark - Lifecircle

- (instancetype)init {
    CGRect frame = CGRectMake(0, 20, DEVICE_WIDTH, 46);
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        lineImageView.backgroundColor = RGBCOLOR(241, 241, 241);
        [self addSubview:lineImageView];
        [self initScrollView];
        [self initLeftRightView];
        [self initSliderView];
    }
    return self;
}

- (instancetype)initWithFrameWithoutFadeLayer:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        lineImageView.backgroundColor = RGBCOLOR(241, 241, 241);
        [self addSubview:lineImageView];
        [self initScrollView];
        [self initSliderView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame showFadeLayer:(BOOL)showFadeLayer showLiner:(BOOL)showLiner{
    if (self = [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        if (showLiner) {
            UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
            lineImageView.backgroundColor = RGBCOLOR(241, 241, 241);
            [self addSubview:lineImageView];
        }
        [self initScrollView];
        [self initSliderView];
        if (showLiner) {
            [self initLeftRightView];
        }
    }
    return self;
}

#pragma - mark Custom Accessors

- (void)setItemsTitle:(NSArray *)itemsTitle {
    _itemsTitle = itemsTitle;
    [self setupItems];
}

- (void)setItemColor:(UIColor *)itemColor {
    for (HBSlideBarItem *item in _items) {
        [item setItemTitleColor:itemColor];
    }
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    for (HBSlideBarItem *item in _items) {
        [item setItemSelectedTitleColor:itemSelectedColor];
    }
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    self.sliderView.backgroundColor = _sliderColor;
}

- (void)setSelectedItem:(HBSlideBarItem *)selectedItem {
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
}

#pragma - mark Private

- (void)initLeftRightView {
    UIImageView *leftImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, self.height)];
    leftImgV.image = [[UIImage imageNamed:@"find_slider_left_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self addSubview:leftImgV];
    self.leftImgV = leftImgV;
    
    UIImageView *rightImgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 30, 0, 30, self.height)];
    rightImgV.image = [[UIImage imageNamed:@"find_slider_right_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self addSubview:rightImgV];
    self.rightImgV = rightImgV;
}

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.bounces = YES;
    [self addSubview:_scrollView];
}

- (void)initSliderView {
    if (self.hideSlideView) {
        return;
    }
    _sliderView = [[UIView alloc] init];
    _sliderColor = DEFAULT_SLIDER_COLOR;
    _sliderView.backgroundColor = _sliderColor;
    [_scrollView addSubview:_sliderView];
}

/**
 * by Soldier
 * 是否平分tab
 */
- (BOOL)isAverage {
    float itemW = 0;
    for (NSString *title in _itemsTitle) {
        if (self.fixedItemWidth > 0 ) {
            itemW += self.fixedItemWidth;
        } else {
            itemW += [HBSlideBarItem widthForTitle:title font:self.titleFont horizontalMargin:(self.horizontalMargin > 0 ? self.horizontalMargin : 0)];
            if (![title isEqualToString:[_itemsTitle firstObject]] &&
                ![title isEqualToString:[_itemsTitle lastObject]]) {
                itemW += self.itemPadding;
            }
        }
    }
    self.allWidth = itemW;
    if (_itemsTitle.count > 1 && itemW < _scrollView.width) {
        if (self.middleStyle) {
            return  NO;
        }
        return YES;
    } else {
        self.middleStyle = NO;
        return NO;
    }
}

- (void)setupItems {
    [_items removeAllObjects];
    
    BOOL isAve = [self isAverage];
    
    for (UIView *itemView in _scrollView.subviews) {
        if ([itemView isKindOfClass:[HBSlideBarItem class]]) {
            HBSlideBarItem *slideBarItem = (HBSlideBarItem *)itemView;
            slideBarItem.delegate = nil;
            [slideBarItem removeFromSuperview];
        }
    }
    CGFloat itemX = self.middleStyle ? (_scrollView.width - self.allWidth) /2.0 :0;
    for (NSString *title in _itemsTitle) {
        HBSlideBarItem *item = [[HBSlideBarItem alloc] init];
        item.delegate = self;
        item.isBoldFont = self.isBoldFont;
        item.backgroundColor = self.itemBackgroundColor ? self.itemBackgroundColor : [UIColor clearColor];
        item.itemBackgroundColor = self.itemBackgroundColor;
        item.itemBgSelectColor = self.itemBgSelectColor;
        
        // Init the current item's frame
        
        /**
         * by Soldier
         */
        CGFloat itemW  = _scrollView.width * 0.5;
        if (isAve) {
            itemW = _scrollView.width / _itemsTitle.count;
        } else {
            if (self.fixedItemWidth > 0) {
                itemW = self.fixedItemWidth;
            }else {
                itemW = [HBSlideBarItem widthForTitle:title font:self.titleFont horizontalMargin:(self.horizontalMargin > 0 ? self.horizontalMargin : 0)];
            }
        }
        
        item.frame = CGRectMake(itemX, 0, itemW, CGRectGetHeight(_scrollView.frame));
        [item setItemTitle:title];
        if (self.titleFont) {
            [item setItemTitleFont:self.titleFont.pointSize];
        }
        if (self.titleSelectedFont) {
            [item setItemSelectedTileFont:self.titleSelectedFont.pointSize];
        }
        [_items addObject:item];
        
        [_scrollView addSubview:item];
        
        // Caculate the origin.x of the next item
        itemX = CGRectGetMaxX(item.frame) + self.itemPadding;
    }
    
    // Cculate the scrollView 's contentSize by all the items
    _scrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_scrollView.frame));
    
    // Set the default selected item, the first item
    HBSlideBarItem *firstItem = [self.items firstObject];
    firstItem.selected = YES;
    _selectedItem = firstItem;
    self.leftImgV.hidden = YES;
    
    if (_sliderView) {
        // Set the frame of sliderView by the selected item
        CGFloat sliderWidth = 0;
        if (self.sliderWidth > 0) {
            sliderWidth = self.sliderWidth;
        }else if (self.sliderWidth < 0) {
            sliderWidth = firstItem.width;
        }
        _sliderView.frame = CGRectMake(0, self.frame.size.height - self.sliderHeight, sliderWidth, self.sliderHeight);
        _sliderView.centerX = firstItem.centerX;
    }
}

- (void)scrollToVisibleItem:(HBSlideBarItem *)item {
    NSInteger selectedItemIndex = [self.items indexOfObject:_selectedItem];
    NSInteger visibleItemIndex = [self.items indexOfObject:item];
    
    // If the selected item is same to the item to be visible, nothing to do
    if (selectedItemIndex == visibleItemIndex ) {
        return;
    }
    
    //中间位置的差值
    CGFloat offsetx = item.center.x - self.scrollView.frame.size.width * 0.5;
    CGFloat offsetMax = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    
    //中间位置的差值小于0说明这item的中点小于中心点，如果大于测移动相应的距离item居中，但是不超过最大的offsetMax
    /**
     * scrollView.contentInset时调整
     * by Soldier
     */
    if (offsetx < 0) {
        offsetx = self.scrollView.contentInset.left > 0 ? (-self.scrollView.contentInset.left) : 0;
    } else if (offsetx > offsetMax){
        offsetx = offsetMax + (self.scrollView.contentInset.right > 0 ? self.scrollView.contentInset.right : 0);
    }
    
    if (self.scrollView.contentSize.width > UI_SCREEN_WIDTH) {
        [_scrollView setContentOffset:CGPointMake(offsetx, self.scrollView.contentOffset.y) animated:YES];
    }
    
    //    CGPoint offset = _scrollView.contentOffset;
    
    // If the item to be visible is in the screen, nothing to do
    //    if (CGRectGetMinX(item.frame) > offset.x && CGRectGetMaxX(item.frame) < (offset.x + CGRectGetWidth(_scrollView.frame))) {
    //        return;
    //    }
    
    //    // Update the scrollView's contentOffset according to different situation
    //    if (selectedItemIndex < visibleItemIndex) {
    //        // The item to be visible is on the right of the selected item and the selected item is out of screeen by the left, also the opposite case, set the offset respectively
    //        if (CGRectGetMaxX(_selectedItem.frame) < offset.x) {
    //            offset.x = CGRectGetMinX(item.frame);
    //        } else {
    //            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
    //        }
    //    } else {
    //        // The item to be visible is on the left of the selected item and the selected item is out of screeen by the right, also the opposite case, set the offset respectively
    //        if (CGRectGetMinX(_selectedItem.frame) > (offset.x + CGRectGetWidth(_scrollView.frame))) {
    //            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
    //        } else {
    //            offset.x = CGRectGetMinX(item.frame);
    //        }
    //    }
    //    _scrollView.contentOffset = offset;
}

- (void)addAnimationWithSelectedItem:(HBSlideBarItem *)item {
    if (!_sliderView) {
        return;
    }
    
    // Caculate the distance of translation
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    
    // Add the animation about translation
    
    if (!self.closeAnimation) {
        CABasicAnimation *positionAnimation = [CABasicAnimation animation];
        positionAnimation.keyPath = @"position.x";
        positionAnimation.fromValue = @(_sliderView.layer.position.x);
        positionAnimation.toValue = @(_sliderView.layer.position.x + dx);
        positionAnimation.duration = 0.2;
        [_sliderView.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
    }
    
    //    // Add the animation about size
    //    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    //    boundsAnimation.keyPath = @"bounds.size.width";
    //    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    //    boundsAnimation.toValue = @(CGRectGetWidth(item.frame));
    //
    //    // Combine all the animations to a group
    //    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    //    animationGroup.animations = @[positionAnimation, boundsAnimation];
    //    animationGroup.duration = 0.2;
    //    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    
    //     Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    if (self.sliderWidth < 0) {
        CGRect rect = _sliderView.layer.bounds;
        rect.size.width = CGRectGetWidth(item.frame);
        _sliderView.layer.bounds = rect;
    }
}

#pragma mark - Public

- (void)slideBarItemSelectedCallback:(HBSlideBarItemSelectedCallback)callback {
    _callback = callback;
}

- (void)selectSlideBarItemAtIndex:(NSUInteger)index {
    HBSlideBarItem *item = nil;
    if (index < self.items.count) {
        item = self.items[index];
    }
    
    if (item == _selectedItem) {
        return;
    }
//    NSLog(@"selectSlideBarItemAtIndex %lu",(unsigned long)index);
    item.selected = YES;
    
    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item];
    
    self.selectedItem = item;
    
    if (index == 0) {
        self.leftImgV.hidden = YES;
        self.rightImgV.hidden = NO;
    } else if (index == self.items.count - 1) {
        self.leftImgV.hidden = NO;
        self.rightImgV.hidden = YES;
    } else {
        self.leftImgV.hidden = NO;
        self.rightImgV.hidden = NO;
    }
}

- (CGFloat)sliderHeight {
    if (_sliderHeight == 0) {
        _sliderHeight = SLIDER_VIEW_HEIGHT;
    }
    return _sliderHeight;
}

- (CGFloat)sliderWidth {
    if (_sliderWidth == 0) {
        _sliderWidth = SLIDER_VIEW_WIDTH;
    }
    return _sliderWidth;
}

#pragma mark - HBSlideBarItemDelegate

- (void)slideBarItemSelected:(HBSlideBarItem *)item {
    if (item == _selectedItem) {
        return;
    }
    
    [self addAnimationWithSelectedItem:item];
    [self scrollToVisibleItem:item];
    
    self.selectedItem = item;
    
    NSInteger index = [self.items indexOfObject:item];
    if (index == 0) {
        self.leftImgV.hidden = YES;
        self.rightImgV.hidden = NO;
    } else if(index == self.items.count - 1) {
        self.leftImgV.hidden = NO;
        self.rightImgV.hidden = YES;
    } else {
        self.leftImgV.hidden = NO;
        self.rightImgV.hidden = NO;
    }
    
    _callback([self.items indexOfObject:item]);
}


@end
