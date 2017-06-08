//
//  DemoCell.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/8.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "DemoCell.h"

@implementation DemoItem


@end





@interface DemoCell () {
    UILabel *_title;
    DemoItem *_item;
}

@end




@implementation DemoCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 60;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, 40)];
        _title.textColor = [UIColor orangeColor];
        _title.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_title];
    }
    return self;
}

- (void)setObject:(id)object {
    if (object != _item) {
        
        _item = object;
        
        _title.text = _item.title;
    }
}


@end
