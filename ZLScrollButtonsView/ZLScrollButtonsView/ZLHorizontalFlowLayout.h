//
//  ZLHorizontalFlowLayout.h
//  ZLScrollButtonsView
//
//  Created by qipai on 2017/12/20.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLHorizontalFlowLayout;
@protocol ZLHorizontalFlowLayoutDelegate<NSObject>
@optional
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(ZLHorizontalFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(ZLHorizontalFlowLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(ZLHorizontalFlowLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page;

@end

@interface ZLHorizontalFlowLayout : UICollectionViewFlowLayout

//指定行数
@property(nonatomic,assign)NSInteger rowCount;
//指定列数
@property(nonatomic,assign)NSInteger columnCount;

@property (nonatomic,assign) id<ZLHorizontalFlowLayoutDelegate> delegate;

@end
