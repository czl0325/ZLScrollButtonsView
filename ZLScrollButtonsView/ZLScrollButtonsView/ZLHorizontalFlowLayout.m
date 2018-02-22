//
//  ZLHorizontalFlowLayout.m
//  ZLScrollButtonsView
//
//  Created by qipai on 2017/12/20.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import "ZLHorizontalFlowLayout.h"

@interface ZLHorizontalFlowLayout()

@property(nonatomic,strong)NSMutableArray* attributesArrayM;

@end

@implementation ZLHorizontalFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.rowCount = 2;
        self.columnCount = 4;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

/** 布局前做一些准备工作 */
- (void)prepareLayout {
    [super prepareLayout];
    // 从collectionView中获取到有多少个item
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    // 遍历出item的attributes,把它添加到管理它的属性数组中去
    for (int i = 0; i < itemTotalCount; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attributesArrayM addObject:attributes];
    }
}

/** 计算collectionView的滚动范围 */
- (CGSize)collectionViewContentSize {
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger page = itemTotalCount/(self.rowCount*self.columnCount);
    if (itemTotalCount%(self.rowCount*self.columnCount) > 0) {
        page = page + 1;
    }
    return CGSizeMake(self.collectionView.frame.size.width * page, 0);
}

/** 设置每个item的属性(主要是frame) */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    CGFloat minimumLineSpacing = 0;
    CGFloat minimumInteritemSpacing = 0.0;
    
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        edgeInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.item];
    } else {
        edgeInsets = self.sectionInset;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        minimumLineSpacing = [_delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:indexPath.item];
    } else {
        minimumLineSpacing = self.minimumLineSpacing;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        minimumInteritemSpacing = [_delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.item];
    } else {
        minimumInteritemSpacing = self.minimumInteritemSpacing;
    }
    
    // item的宽高由行列间距和collectionView的内边距决定
    CGFloat itemWidth = (self.collectionView.frame.size.width - edgeInsets.left - edgeInsets.right - minimumInteritemSpacing * self.columnCount) / self.columnCount;
    CGFloat itemHeight = (self.collectionView.frame.size.height - edgeInsets.top - edgeInsets.bottom - (self.rowCount - 1) * minimumLineSpacing) / self.rowCount;
    
    NSInteger item = indexPath.item;
    // 当前item所在的页
    NSInteger pageNumber = item / (self.rowCount * self.columnCount);
    NSInteger x = item % self.columnCount;
    NSInteger y = item / self.columnCount - pageNumber * self.rowCount;
    
    // 计算出item的坐标
    CGFloat itemX = (self.collectionView.frame.size.width * pageNumber) + edgeInsets.left + (itemWidth + minimumInteritemSpacing) * x;
    CGFloat itemY = edgeInsets.top + (itemHeight + minimumLineSpacing) * y;
    
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    // 每个item的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    return attributes;
}

/** 返回collectionView视图中所有视图的属性数组 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArrayM;
}


#pragma mark - Lazy
- (NSMutableArray *)attributesArrayM {
    if (!_attributesArrayM) {
        _attributesArrayM = [NSMutableArray array];
    }
    return _attributesArrayM;
}

@end
