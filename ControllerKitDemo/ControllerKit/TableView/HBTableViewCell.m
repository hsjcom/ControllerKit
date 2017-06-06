//
//  HBTableViewCell.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/6.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBTableViewCell.h"

@interface HBTableViewCell ()

@end



@implementation HBTableViewCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIView *bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(0, 0, self.width, self.height);
        bgView.backgroundColor = RGBACOLOR(0, 0, 0, 0.1);
        self.selectedBackgroundView = bgView;
    }
    return self;
}

- (id)object {
    return nil;
}

- (void)prepareForReuse {
    self.object = nil;
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    [super prepareForReuse];
}

- (void)setObject:(id)object {
    if (!object) {
        return;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
