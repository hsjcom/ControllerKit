//
//  HBSlideBarItem.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBSlideBarItem.h"

#define DEFAULT_TITLE_FONTSIZE 15
#define DEFAULT_TITLE_SELECTED_FONTSIZE 15
#define DEFAULT_TITLE_COLOR RGBCOLOR(53, 53, 53)
#define DEFAULT_TITLE_SELECTED_COLOR RGBCOLOR(53, 53, 53)

#define HORIZONTAL_MARGIN 14

@interface HBSlideBarItem ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat selectedFontSize;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *selectedColor;

@end



@implementation HBSlideBarItem

#pragma mark - Lifecircle

- (instancetype) init {
    if (self = [super init]) {
        _fontSize = DEFAULT_TITLE_FONTSIZE;
        _selectedFontSize = DEFAULT_TITLE_SELECTED_FONTSIZE;
        _color = DEFAULT_TITLE_COLOR;
        _selectedColor = DEFAULT_TITLE_SELECTED_COLOR;
        
        self.backgroundColor = self.itemBackgroundColor ? self.itemBackgroundColor : [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat titleX = (CGRectGetWidth(self.frame) - [self titleSize].width) * 0.5;
    CGFloat titleY = (CGRectGetHeight(self.frame) - [self titleSize].height) * 0.5;
    
    CGRect titleRect = CGRectMake(titleX, titleY, [self titleSize].width, [self titleSize].height);
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont], NSForegroundColorAttributeName : [self titleColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:_title attributes:attributes];
    [attributedString drawInRect:titleRect];
//    [_title drawInRect:titleRect withAttributes:attributes];
}

#pragma mark - Custom Accessors

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    if (self.itemBgSelectColor) {
        if (selected) {
            self.backgroundColor = self.itemBgSelectColor;
        } else {
            self.backgroundColor = self.itemBackgroundColor ? self.itemBackgroundColor : [UIColor clearColor];
        }
    }
    
    [self setNeedsDisplay];
}

#pragma mark - Public

- (void)setItemTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay];
}

- (void)setItemTitleFont:(CGFloat)fontSize {
    _fontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTileFont:(CGFloat)fontSize {
    _selectedFontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemTitleColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTitleColor:(UIColor *)color {
    _selectedColor = color;
    [self setNeedsDisplay];
}

#pragma mark - Private

- (CGSize)titleSize {
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_title attributes:attributes];
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//    CGSize size = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (UIFont *)titleFont {
    UIFont *font;
    if (_selected) {
        font = self.isBoldFont ? [UIFont boldSystemFontOfSize:_selectedFontSize] : [UIFont systemFontOfSize:_selectedFontSize];
    } else {
        font = self.isBoldFont ? [UIFont boldSystemFontOfSize:_fontSize] : [UIFont systemFontOfSize:_fontSize];
    }
    return font;
}

- (UIColor *)titleColor {
    UIColor *color;
    if (_selected) {
        if (_selectedColor) {
            color = _selectedColor;
        }else {
            color = DEFAULT_TITLE_SELECTED_COLOR;
        }
    } else if (_color){
        color = _color;
    } else {
        color = DEFAULT_TITLE_COLOR;
    }
    return color;
}

#pragma mark - Public Class Method

+ (CGFloat)widthForTitle:(NSString *)title font:(UIFont *)font horizontalMargin:(CGFloat)horizontalMargin {
    if (!font) {
        font = [UIFont systemFontOfSize:DEFAULT_TITLE_FONTSIZE];
    }
    NSDictionary *attributes = @{NSFontAttributeName : font};
//    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    size.width = ceil(size.width) + (horizontalMargin > 0 ? horizontalMargin : HORIZONTAL_MARGIN * 2);
    
    return size.width;
}

#pragma mark - Responder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideBarItemSelected:)]) {
        [self.delegate slideBarItemSelected:self];
    }
}

@end
