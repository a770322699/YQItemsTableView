//
//  YQItemsTableView.m
//  Demo
//
//  Created by maygolf on 16/11/22.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import "YQItemsTableView.h"

#import "YQItemsTableViewLayout.h"

static NSString * const kCalculateHeightCellIdentifier = @"kCalculateHeightCellIdentifier";

@interface YQItemsTableView ()<YQColletionViewDelegateItemsTableViewLayout, UICollectionViewDataSource>
{
    struct {
        BOOL numberOfSectionFlag;
        BOOL numberOfItemsFlag;
        BOOL limiteLine;
        BOOL heighForHeader;
        BOOL heighForFooter;
        BOOL sectionInsets;
        BOOL minimumLineSpacing;
        BOOL minimumInteritemSpacing;
        BOOL titleForHeader;
        BOOL titleForFooter;
        BOOL viewForHeader;
        BOOL viewForFooter;
        BOOL titleForItem;
        BOOL configCell;
        BOOL configHeader;
        BOOL configFooter;
        BOOL didSelected;
    } _delegateFlag;
}

@property (nonatomic, readonly) YQItemsTableViewLayout *yq_layout;

@property (nonatomic, assign) NSInteger numberOfSecton;
@property (nonatomic, strong) YQItemsTableViewItemCell *heightCell;

@end

@implementation YQItemsTableView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    YQItemsTableViewLayout *yqLayout = [[YQItemsTableViewLayout alloc] init];
    if (self = [super initWithFrame:frame collectionViewLayout:yqLayout]) {
        [self registerClass:[YQItemsTableViewItemCell class] forCellWithReuseIdentifier:kYQItemsTableViewItemCellReuserIdentifier];
        [self registerClass:[YQItemsTableViewItemCell class] forCellWithReuseIdentifier:kCalculateHeightCellIdentifier];
        [self registerClass:[YQItemsTableHeaderFooterTextView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kYQItemsTableHeaderFooterTextViewReuserIdentifier];
         [self registerClass:[YQItemsTableHeaderFooterTextView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kYQItemsTableHeaderFooterTextViewReuserIdentifier];
        
        self.delegate = self;
        self.dataSource = self;
        
        _numberOfSecton = 1;
        _headerHeight = 30.0;
        _footerHeight = 0;
        _limiteLine = 0;
        _sectionContentInsets = UIEdgeInsetsMake(10.0, 12.0, 10.0, 12.0);
        _minimumLineSpacing = 10.0;
        _minimumLineSpacing = 20.0;
    }
    return self;
}

#pragma mark - getter
- (YQItemsTableViewLayout *)yq_layout{
    return (YQItemsTableViewLayout *)self.collectionViewLayout;
}

#pragma mark - setting
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate{
    [super setDelegate:self];
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource{
    [super setDataSource:self];
}

- (void)setYq_delegate:(id<YQItemsTableViewDelegate>)yq_delegate{
    _yq_delegate = yq_delegate;
    
    _delegateFlag.numberOfSectionFlag = yq_delegate && [yq_delegate respondsToSelector:@selector(numberOfSectionsInItemsTableView:)];
    _delegateFlag.numberOfItemsFlag = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:numberOfItemsInSection:)];
    _delegateFlag.limiteLine = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:limiteLineInsection:)];
    _delegateFlag.heighForHeader = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:heightForHeaderInSection:)];
    _delegateFlag.heighForFooter = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:heightForFooterInSection:)];
    _delegateFlag.sectionInsets = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:insetsInSection:)];
    _delegateFlag.minimumLineSpacing = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:minimumLineSpacingForSectionAtIndex:)];
    _delegateFlag.minimumInteritemSpacing = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:minimumInteritemSpacingForSectionAtIndex:)];
    _delegateFlag.viewForHeader = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:viewForHeaderInSection:)];
    _delegateFlag.viewForFooter = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:viewForFooterInSection:)];
    _delegateFlag.titleForItem = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:titleForIndexPath:)];
    _delegateFlag.titleForHeader = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:titleForHeaderInSection:)];
    _delegateFlag.titleForFooter = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:titleForFooterInSection:)];
    _delegateFlag.configCell = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:configCell:atIndexPath:)];
    _delegateFlag.configHeader = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:configTitleHeader:atSection:)];
    _delegateFlag.configFooter = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:configTitleFooter:atSection:)];
    _delegateFlag.didSelected = yq_delegate && [yq_delegate respondsToSelector:@selector(itemsTableView:didSelectItemAtIndexPath:)];
}

#pragma mark - private
- (void)configCell:(YQItemsTableViewItemCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if (_delegateFlag.titleForItem){
        cell.text = [self.yq_delegate itemsTableView:self titleForIndexPath:indexPath];
    }
    
    if (_delegateFlag.configCell) {
        [self.yq_delegate itemsTableView:self configCell:cell atIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegate
- (CGFloat)colletionView:(UICollectionView *)colletionView headerHeightForSection:(NSInteger)section{
    if (_delegateFlag.heighForHeader) {
        return [self.yq_delegate itemsTableView:self heightForHeaderInSection:section];
    }
    return self.headerHeight;
}

- (CGFloat)colletionView:(UICollectionView *)colletionView footerHeightForSection:(NSInteger)section{
    if (_delegateFlag.heighForFooter) {
        return [self.yq_delegate itemsTableView:self heightForFooterInSection:section];
    }
    return self.footerHeight;
}

- (NSInteger)colletionView:(UICollectionView *)colletionView limiteLineInsection:(NSInteger)section{
    if (_delegateFlag.limiteLine) {
        return [self.yq_delegate itemsTableView:self limiteLineInsection:section];
    }
    return self.limiteLine;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (_delegateFlag.didSelected) {
        [self.yq_delegate itemsTableView:self didSelectItemAtIndexPath:indexPath];
    }
}

- (UIEdgeInsets)colletionView:(UICollectionView *)colletionView insetsInSection:(NSInteger)section{
    if (_delegateFlag.sectionInsets) {
        return [self.yq_delegate itemsTableView:self insetsInSection:section];
    }
    
    return self.sectionContentInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (_delegateFlag.minimumLineSpacing) {
        return [self.yq_delegate itemsTableView:self minimumLineSpacingForSectionAtIndex:section];
    }
    return self.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (_delegateFlag.minimumInteritemSpacing) {
        return [self.yq_delegate itemsTableView:self minimumInteritemSpacingForSectionAtIndex:section];
    }
    
    return self.minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView itemSizeAtIndexPath:(NSIndexPath *)indexPath{
    if (!_heightCell) {
        _heightCell = [[YQItemsTableViewItemCell alloc] init];
    }
    
    [self configCell:_heightCell atIndexPath:indexPath];
    
    return [_heightCell fitSize];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_delegateFlag.numberOfSectionFlag) {
        self.numberOfSecton = [self.yq_delegate numberOfSectionsInItemsTableView:self];
    }
    return self.numberOfSecton;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_delegateFlag.numberOfItemsFlag) {
        NSInteger expectedNumber = [self.yq_delegate itemsTableView:self numberOfItemsInSection:section];
        return [self.yq_layout limitItemsNumberAtSection:section expectedNumber:expectedNumber];
    }
    
    NSException *exception = [NSException exceptionWithName:@"数据异常" reason:@"yq_delegate must implementation - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section, but current delegate no" userInfo:nil];
    @throw exception;
    
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (_delegateFlag.viewForHeader) {
            return [self.yq_delegate itemsTableView:self viewForHeaderInSection:indexPath.section];
        }else if (_delegateFlag.titleForHeader){
            YQItemsTableHeaderFooterTextView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYQItemsTableHeaderFooterTextViewReuserIdentifier forIndexPath:indexPath];
            view.text = [self.yq_delegate itemsTableView:self titleForHeaderInSection:indexPath.section];
            if (_delegateFlag.configHeader) {
                [self.yq_delegate itemsTableView:self configTitleHeader:view atSection:indexPath.section];
            }
            return view;
        }
    }else if (kind == UICollectionElementKindSectionFooter){
        if (_delegateFlag.viewForFooter) {
            return [self.yq_delegate itemsTableView:self viewForFooterInSection:indexPath.section];
        }else if (_delegateFlag.titleForFooter){
            YQItemsTableHeaderFooterTextView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYQItemsTableHeaderFooterTextViewReuserIdentifier forIndexPath:indexPath];
            view.text = [self.yq_delegate itemsTableView:self titleForFooterInSection:indexPath.section];
            if (_delegateFlag.configFooter) {
                [self.yq_delegate itemsTableView:self configTitleFooter:view atSection:indexPath.section];
            }
            
            return view;
        }
    }
    
    return nil;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YQItemsTableViewItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYQItemsTableViewItemCellReuserIdentifier forIndexPath:indexPath];
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

@end
