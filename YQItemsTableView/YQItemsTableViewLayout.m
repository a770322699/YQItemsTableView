//
//  YQItemsTableViewLayout.m
//  Demo
//
//  Created by maygolf on 16/11/22.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import "YQItemsTableViewLayout.h"

@interface YQItemsTableViewLayoutSection : NSObject

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) NSInteger lineNumber;
@property (nonatomic, assign) NSInteger itemsNumber;
@property (nonatomic, strong) NSMutableDictionary *lineCounts;
@property (nonatomic, strong) NSMutableDictionary *itemFrames;

@end

@implementation YQItemsTableViewLayoutSection

- (instancetype)init{
    if (self = [super init]) {
        _lineCounts = [NSMutableDictionary dictionary];
        _itemFrames = [NSMutableDictionary dictionary];
    }
    return self;
}

@end

/***********************************************************************************************/
/***********************************************************************************************/

@interface YQItemsTableViewLayout ()

@property (nonatomic, readonly) id<YQColletionViewDelegateItemsTableViewLayout> delegate;
@property (nonatomic, readonly) id<UICollectionViewDataSource> dataSource;

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, copy) NSArray *layoutAttributes;

@end

@implementation YQItemsTableViewLayout

- (instancetype)init{
    if (self = [super init]) {
        _sections = [NSMutableArray array];
    }
    return self;
}

#pragma mark - override
- (CGSize)collectionViewContentSize{
    CGFloat height = 0;
    for (YQItemsTableViewLayoutSection *sectionInfo in self.sections) {
        height += sectionInfo.height;
    }
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = self.layoutAttributes;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        NSIndexPath *indexPath = attribute.indexPath;
        
        if (attribute.representedElementCategory == UICollectionElementCategoryCell) {
            CGFloat relativeY = 0;
            CGRect frame = CGRectZero;
            for (int i = 0; i <= indexPath.section; i++) {
                YQItemsTableViewLayoutSection *sectionInfo = self.sections[i];
                
                if (i < indexPath.section) {
                    relativeY += sectionInfo.height;
                }else if (i == indexPath.section){
                    relativeY += sectionInfo.headerHeight;
                    
                    frame = [sectionInfo.itemFrames[@(indexPath.item)] CGRectValue];
                    frame.origin.y += relativeY;
                }
            }
            
            attribute.frame = frame;
        }else if(attribute.representedElementCategory == UICollectionElementCategorySupplementaryView){
            CGFloat relativeY = 0;
            CGRect frame = CGRectZero;
            for (int i = 0; i <= indexPath.section; i++) {
                YQItemsTableViewLayoutSection *sectionInfo = self.sections[i];
                
                if (i < indexPath.section) {
                    relativeY += sectionInfo.height;
                }else if (i == indexPath.section){
                    if (attribute.representedElementKind == UICollectionElementKindSectionFooter) {
                        relativeY += sectionInfo.height - sectionInfo.footerHeight;
                        frame = CGRectMake(0, relativeY, self.collectionView.bounds.size.width, sectionInfo.footerHeight);
                    }else{
                        frame = CGRectMake(0, relativeY, self.collectionView.bounds.size.width, sectionInfo.headerHeight);
                    }
                }
            }
            
            attribute.frame = frame;
        }
    }
    
    return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGFloat relativeY = 0;
    CGRect frame = CGRectZero;
    for (int i = 0; i <= indexPath.section; i++) {
        YQItemsTableViewLayoutSection *sectionInfo = self.sections[i];
        
        if (i < indexPath.section) {
            relativeY += sectionInfo.height;
        }else if (i == indexPath.section){
            relativeY += sectionInfo.headerHeight;
            
            frame = [sectionInfo.itemFrames[@(indexPath.item)] CGRectValue];
            frame.origin.y += relativeY;
        }
    }
    
    attributes.frame = frame;
    return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGFloat relativeY = 0;
    CGRect frame = CGRectZero;
    for (int i = 0; i <= indexPath.section; i++) {
        YQItemsTableViewLayoutSection *sectionInfo = self.sections[i];
        
        if (i < indexPath.section) {
            relativeY += sectionInfo.height;
        }else if (i == indexPath.section){
            if (elementKind == UICollectionElementKindSectionFooter) {
                relativeY += sectionInfo.height - sectionInfo.footerHeight;
                frame = CGRectMake(0, relativeY, self.collectionView.bounds.size.width, sectionInfo.footerHeight);
            }else{
                frame = CGRectMake(0, relativeY, self.collectionView.bounds.size.width, sectionInfo.headerHeight);
            }
        }
    }
    
    attributes.frame = frame;
    return attributes;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    [self.sections removeAllObjects];
    
    NSInteger sectionNumber = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sectionNumber = [self.dataSource numberOfSectionsInCollectionView:self.collectionView];
    }
    
    for (int i = 0; i < sectionNumber; i++) {
        
        NSInteger itemsNumber = 0;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            itemsNumber = [self.dataSource collectionView:self.collectionView numberOfItemsInSection:i];
        }
        YQItemsTableViewLayoutSection *section = [self sectionInSection:i itemsCount:itemsNumber];
        
        [self.sections addObject:section];
    }
    
    NSMutableArray *attributes = [NSMutableArray array];
    for (int i = 0; i < self.sections.count; i++) {
        YQItemsTableViewLayoutSection *sectionInfo = self.sections[i];
        
        // 头部
        UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        [attributes addObject:headerAttributes];
        
        // 尾部
        UICollectionViewLayoutAttributes *footerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        [attributes addObject:footerAttributes];
        
        for (int j = 0; j < sectionInfo.itemsNumber; j++) {
            UICollectionViewLayoutAttributes *cellAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
            [attributes addObject:cellAttributes];
        }
    }
    self.layoutAttributes = attributes;
}

#pragma mark - getter
- (id<YQColletionViewDelegateItemsTableViewLayout>)delegate{
    return (id<YQColletionViewDelegateItemsTableViewLayout>)self.collectionView.delegate;
}

- (id<UICollectionViewDataSource>)dataSource{
    return (id<UICollectionViewDataSource>)self.collectionView.dataSource;
}

#pragma mark - private
- (YQItemsTableViewLayoutSection *)sectionInSection:(NSInteger)index itemsCount:(NSInteger)itemsCount{
    YQItemsTableViewLayoutSection *section = [[YQItemsTableViewLayoutSection alloc] init];
    if (self.delegate && [self.delegate respondsToSelector:@selector(colletionView:headerHeightForSection:)]) {
        section.headerHeight = [self.delegate colletionView:self.collectionView headerHeightForSection:index];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(colletionView:footerHeightForSection:)]) {
        section.footerHeight = [self.delegate colletionView:self.collectionView footerHeightForSection:index];
    }
    
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (self.delegate && [self.delegate respondsToSelector:@selector(colletionView:insetsInSection:)]) {
        insets = [self.delegate colletionView:self.collectionView insetsInSection:index];
    }
    
    CGFloat minLineSpace = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:minimumLineSpacingForSectionAtIndex:)]) {
        minLineSpace = [self.delegate collectionView:self.collectionView minimumLineSpacingForSectionAtIndex:index];
    }
    
    CGFloat minInteremSpace = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:minimumInteritemSpacingForSectionAtIndex:)]) {
        minInteremSpace = [self.delegate collectionView:self.collectionView minimumInteritemSpacingForSectionAtIndex:index];
    }
    
    // 获取极限行数
    NSInteger limiteLine = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(colletionView:limiteLineInsection:)]) {
        limiteLine = [self.delegate colletionView:self.collectionView limiteLineInsection:index];
    }
    
    CGFloat valibaleWidth = self.collectionView.bounds.size.width - insets.left - insets.right;
    CGFloat startX = insets.left;
    CGFloat maxHeightCurrentLine = 0;
    CGFloat maxYBeforLine = 0;
    CGFloat maxYCurrentLine = 0;
    NSInteger startIndexCurrentLine = 0;
    for (int j = 0; j < itemsCount; j++) {
        CGSize size = CGSizeZero;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:itemSizeAtIndexPath:)]) {
            size = [self.delegate collectionView:self.collectionView itemSizeAtIndexPath:[NSIndexPath indexPathForItem:j inSection:index]];
        }
        
        CGRect frame = CGRectZero;
        if (j == startIndexCurrentLine) {// 每行的第一个
            CGFloat y = maxYBeforLine ? maxYBeforLine + minLineSpace : insets.top;
            frame = CGRectMake(startX, y, MIN(size.width, valibaleWidth), size.height);
            section.itemFrames[@(j)] = [NSValue valueWithCGRect:frame];
            
            maxHeightCurrentLine = size.height;
            maxYCurrentLine = CGRectGetMaxY(frame);
            
            if (j == itemsCount - 1) {
                section.lineCounts[@(section.lineNumber)] = @(j - startIndexCurrentLine + 1);
                section.lineNumber = section.lineNumber + 1;
                section.itemsNumber = section.itemsNumber + j - startIndexCurrentLine + 1;
            }
        }else{
            CGRect beforFrame = [section.itemFrames[@(j - 1)] CGRectValue];
            CGFloat x = beforFrame.origin.x + beforFrame.size.width + minInteremSpace;
            if (x + size.width <= valibaleWidth) {
                // 当前行还能放下这个item
                CGFloat y = 0;
                if (size.height > maxHeightCurrentLine) {
                    y = maxYBeforLine ? maxYBeforLine + minLineSpace : insets.top;
                    maxHeightCurrentLine = size.height;
                    maxYCurrentLine = y + size.height;
                    for (NSInteger z = startIndexCurrentLine; z < j; z++) {
                        NSNumber *Key = @(z);
                        CGRect frame = [section.itemFrames[Key] CGRectValue];
                        frame.origin.y = y + (size.height - frame.size.height) / 2;
                        section.itemFrames[Key] = [NSValue valueWithCGRect:frame];
                    }
                }else{
                    y = maxYBeforLine ? maxYBeforLine + minLineSpace : insets.top;
                    y = y + (maxHeightCurrentLine - size.height) / 2;
                }
                frame = CGRectMake(x, y, size.width, size.height);
                section.itemFrames[@(j)] = [NSValue valueWithCGRect:frame];
                
                if (j == itemsCount - 1) {
                    section.lineCounts[@(section.lineNumber)] = @(j - startIndexCurrentLine + 1);
                    section.lineNumber = section.lineNumber + 1;
                    section.itemsNumber = section.itemsNumber + j - startIndexCurrentLine + 1;
                }
                
            }else{
                
                section.lineCounts[@(section.lineNumber)] = @(j - startIndexCurrentLine);
                section.lineNumber = section.lineNumber + 1;
                section.itemsNumber = section.itemsNumber + j - startIndexCurrentLine;
                
                maxYBeforLine = maxYCurrentLine;
                startIndexCurrentLine = j;
                
                // 如果达到极限行数，跳出循环
                if (limiteLine && limiteLine <= section.lineNumber) {
                    section.height = section.headerHeight + section.footerHeight + maxYBeforLine + insets.bottom;
                    break;
                }
                
                // 这个值还需要执行一次循环，因此需要先减1，和+1抵消
                j--;
            }
        }
        
        if (j == itemsCount - 1) {
            section.height = section.headerHeight + section.footerHeight + maxYCurrentLine + insets.bottom;
        }
    }
    
    return section;
}

#pragma mark - public
// 最多可以显示的数量
- (NSInteger)limitItemsNumberAtSection:(NSInteger)section expectedNumber:(NSInteger)expectedNumber{
    
    // 获取极限行数
    NSInteger limiteLine = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(colletionView:limiteLineInsection:)]) {
        limiteLine = [self.delegate colletionView:self.collectionView limiteLineInsection:section];
    }
    
    // 若极限行数为0，返回期待的item数量
    if (limiteLine == 0) {
        return expectedNumber;
    }
    
    NSInteger resultNumber = 0;
    YQItemsTableViewLayoutSection *sectionInfo = [self sectionInSection:section itemsCount:expectedNumber];
    for (int i = 0; i < sectionInfo.lineNumber; i++) {
        resultNumber += [sectionInfo.lineCounts[@(i)] integerValue];
    }
    
    return resultNumber;
}


@end
