//
//  HBCollectionViewCell.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBCollectionViewCell.h"
#import "HBCollectionViewItem.h"

@interface HBCollectionViewCell () {
    UIButton *_coverBtn;
    HBCollectionViewItem *_object;
}

@end





@implementation HBCollectionViewCell

- (void)dealloc {
}

+ (CGFloat)collectionView:(UICollectionView *)collectionView rowHeightForObject:(id)object {
    return 88;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)object {
    return _object;
}

- (void)prepareForReuse {
    self.object = nil;
    [super prepareForReuse];
}

- (void)setObject:(id)object {
    if (object != _object) {
        _object = object;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)gridClick{
    HBCollectionViewItem *item = (HBCollectionViewItem *)self.object;
    if (item.delegate && [item.delegate respondsToSelector:item.selector] && item.selector) {
        [item.delegate performSelector:item.selector withObject:item afterDelay:0.0]; //afterDelay 消除警告
    }
}

//设置点按效果的
- (void)setCoverBtnEnable{
    if (!_coverBtn) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverBtn.frame = self.bounds;
        [_coverBtn addTarget:self action:@selector(gridClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_coverBtn];
    }
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [_coverBtn removeTarget:self action:@selector(gridClick) forControlEvents:controlEvents];
    [_coverBtn addTarget:target action:action forControlEvents:controlEvents];
}


@end
