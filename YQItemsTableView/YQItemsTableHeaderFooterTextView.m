//
//  YQItemsTableHeaderFooterTextView.m
//  Demo
//
//  Created by maygolf on 16/11/23.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import "YQItemsTableHeaderFooterTextView.h"

@interface YQItemsTableHeaderFooterTextView ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSLayoutConstraint *insetTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *insetLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *insetBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *insetRightConstraint;

@end

@implementation YQItemsTableHeaderFooterTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
        
        self.insetTopConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        self.insetLeftConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        self.insetBottomConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        self.insetRightConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        [self addConstraints:@[self.insetTopConstraint, self.insetLeftConstraint, self.insetBottomConstraint, self.insetRightConstraint]];
    }
    return self;
}

#pragma mark - getter
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _label;
}

#pragma mark - setting
- (void)setText:(NSString *)text{
    self.label.text = text;
    _text = text;
}

- (void)setInsets:(UIEdgeInsets)insets{
    self.insetTopConstraint.constant = insets.top;
    self.insetLeftConstraint.constant = insets.left;
    self.insetBottomConstraint.constant = -insets.bottom;
    self.insetRightConstraint.constant = -insets.right;
    
    _insets = insets;
}

- (void)setTextFont:(UIFont *)textFont{
    self.label.font = textFont;
    _textFont = textFont;
}

- (void)setTextColor:(UIColor *)textColor{
    self.label.textColor = textColor;
    _textColor = textColor;
}

@end
