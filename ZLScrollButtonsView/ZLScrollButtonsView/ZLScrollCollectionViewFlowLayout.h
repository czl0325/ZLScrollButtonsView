//
//  ZLScrollCollectionViewFlowLayout.h
//  ZLScrollButtonsView
//
//  Created by qipai on 2017/12/18.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLScrollCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>
@optional
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page;
@end

@interface ZLScrollCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<ZLScrollCollectionViewFlowLayoutDelegate> delegate;

@end
