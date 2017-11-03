//
//  ZLScrollButtonsView.h
//  ZLScrollButtonsView
//
//  Created by zhaoliang chen on 2017/10/30.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLScrollButtonsView;
@protocol ZLScrollButtonsViewDelegate <NSObject>

@optional
- (void)onClickScrollButton:(ZLScrollButtonsView*)zlScrollViewButtonView index:(NSInteger)index;

@end

@interface ZLScrollButtonsView : UIScrollView

//单页里面显示多少个元素
@property(nonatomic, assign)NSInteger itemsNumOnPage;
@property(nonatomic, assign)id<ZLScrollButtonsViewDelegate> zlDelegate;

- (void)reloadScrllButtons:(NSArray*)array;
- (UIButton*)getButtonByIndex:(NSInteger)index;

@end
