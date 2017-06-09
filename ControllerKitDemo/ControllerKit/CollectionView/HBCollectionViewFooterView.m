//
//  HBCollectionViewFooterView.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBCollectionViewFooterView.h"
#import "HBCollectionViewItem.h"


@interface HBCollectionViewFooterView () {
    HBCollectionViewItem *_object;
}

@end




@implementation HBCollectionViewFooterView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)object {
    return _object;
}

- (void)setObject:(id)object {
    if (object != _object) {
        _object = object;
    }
}


@end
