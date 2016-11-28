//
//  YQItemsTableView.h
//  Demo
//
//  Created by maygolf on 16/11/22.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQItemsTableViewItemCell.h"
#import "YQItemsTableHeaderFooterTextView.h"

NS_ASSUME_NONNULL_BEGIN

@class YQItemsTableView;

@protocol YQItemsTableViewDelegate <NSObject>

@required
- (NSInteger)itemsTableView:(YQItemsTableView *)tableView numberOfItemsInSection:(NSInteger)section;

@optional
- (NSInteger)numberOfSectionsInItemsTableView:(YQItemsTableView *)tableView;

- (NSInteger)itemsTableView:(YQItemsTableView *)tableView limiteLineInsection:(NSInteger)section;
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIEdgeInsets)itemsTableView:(YQItemsTableView *)tableView insetsInSection:(NSInteger)section;
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (nullable NSString *)itemsTableView:(YQItemsTableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (nullable NSString *)itemsTableView:(YQItemsTableView *)tableView titleForFooterInSection:(NSInteger)section;
- (nullable UICollectionReusableView *)itemsTableView:(YQItemsTableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (nullable UICollectionReusableView *)itemsTableView:(YQItemsTableView *)tableView viewForFooterInSection:(NSInteger)section;

- (NSString *)itemsTableView:(YQItemsTableView *)tableView titleForIndexPath:(NSIndexPath *)indexPath;
- (void)itemsTableView:(YQItemsTableView *)tableView configCell:(YQItemsTableViewItemCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)itemsTableView:(YQItemsTableView *)tableView configTitleHeader:(YQItemsTableHeaderFooterTextView *)header atSection:(NSInteger)section;
- (void)itemsTableView:(YQItemsTableView *)tableView configTitleFooter:(YQItemsTableHeaderFooterTextView *)footer atSection:(NSInteger)section;

- (void)itemsTableView:(YQItemsTableView *)tableView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YQItemsTableView : UICollectionView

@property (nonatomic, weak) id<YQItemsTableViewDelegate> yq_delegate;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) NSInteger limiteLine;
@property (nonatomic, assign) UIEdgeInsets sectionContentInsets;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@end


NS_ASSUME_NONNULL_END
