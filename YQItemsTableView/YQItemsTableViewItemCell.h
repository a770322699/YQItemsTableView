//
//  YQItemsTableViewItemCell.h
//  Demo
//
//  Created by maygolf on 16/11/22.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kYQItemsTableViewItemCellReuserIdentifier = @"kYQItemsTableViewItemCellReuserIdentifier";

@interface YQItemsTableViewItemCell : UICollectionViewCell

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highLightColor;

- (CGSize)fitSize;

@end
