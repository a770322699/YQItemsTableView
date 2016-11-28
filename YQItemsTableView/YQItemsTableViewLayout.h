//
//  YQItemsTableViewLayout.h
//  Demo
//
//  Created by maygolf on 16/11/22.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YQColletionViewDelegateItemsTableViewLayout <UICollectionViewDelegate>

- (CGFloat)colletionView:(UICollectionView *)colletionView headerHeightForSection:(NSInteger)section;
- (CGFloat)colletionView:(UICollectionView *)colletionView footerHeightForSection:(NSInteger)section;
- (NSInteger)colletionView:(UICollectionView *)colletionView limiteLineInsection:(NSInteger)section;
- (UIEdgeInsets)colletionView:(UICollectionView *)colletionView insetsInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView itemSizeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YQItemsTableViewLayout : UICollectionViewLayout

// 最多可以显示的数量
- (NSInteger)limitItemsNumberAtSection:(NSInteger)section expectedNumber:(NSInteger)expectedNumber;

@end
