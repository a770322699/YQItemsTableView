//
//  YQItemsTableViewItemCell.m
//  Demo
//
//  Created by maygolf on 16/11/22.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import "YQItemsTableViewItemCell.h"

@interface YQItemsTableViewItemCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation YQItemsTableViewItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.label];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        
        self.insets = UIEdgeInsetsMake(5, 10, 5, 10);
        self.borderColor = [UIColor clearColor];
        self.highLightColor = [UIColor colorWithRed:80.0/255 green:80.0/255 blue:80.0/255 alpha:1];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = self.borderColor.CGColor;
}

#pragma mark - getter
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _label;
}

#pragma mark - setting
- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
    _borderColor = borderColor;
}

- (void)setTextFont:(UIFont *)textFont{
    self.label.font = textFont;
    _textFont = textFont;
}

- (void)setTextColor:(UIColor *)textColor{
    self.label.textColor = textColor;
    _textColor = textColor;
}

- (void)setHighLightColor:(UIColor *)highLightColor{
    self.selectedBackgroundView.backgroundColor = highLightColor;
    _highLightColor = highLightColor;
}

- (void)setText:(NSString *)text{
    self.label.text = text;
    _text = text;
}

#pragma mark - public
- (CGSize)fitSize{
    CGSize labelSize = [self.label intrinsicContentSize];
    
    CGFloat height = labelSize.height + self.insets.top + self.insets.bottom;
    CGFloat widht = labelSize.width + MAX(self.insets.left, height / 2) + MAX(self.insets.right, height / 2);
    return CGSizeMake(widht, height);
}

@end
