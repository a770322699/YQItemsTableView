//
//  YQItemsTableHeaderFooterTextView.h
//  Demo
//
//  Created by maygolf on 16/11/23.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kYQItemsTableHeaderFooterTextViewReuserIdentifier = @"kYQItemsTableHeaderFooterTextViewReuserIdentifier";

@interface YQItemsTableHeaderFooterTextView : UICollectionReusableView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;

@end
