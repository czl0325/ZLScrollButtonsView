//
//  ZLScrollButtonsView.m
//  ZLScrollButtonsView
//
//  Created by zhaoliang chen on 2017/10/30.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import "ZLScrollButtonsView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface ZLScrollButtonsView()

@property(nonatomic,strong)UIView* contentView;
@property(nonatomic,strong)NSMutableArray* arrayButtons;

@end

@implementation ZLScrollButtonsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.itemsNumOnPage = 6;
        self.arrayButtons = [NSMutableArray new];
        
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.edges.mas_equalTo(self);
            make.height.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)reloadScrllButtons:(NSArray*)array {
    [self.arrayButtons removeAllObjects];
    while (self.contentView.subviews.count) {
        UIView* child = self.contentView.subviews.lastObject;
        [child removeFromSuperview];
    }
    
    NSInteger pages = array.count/self.itemsNumOnPage+(array.count%self.itemsNumOnPage==0?0:1);
    UIView* tempView = nil;
    NSInteger index = 0;
    for (int i=0; i<pages; i++) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tempView == nil)  {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(tempView.mas_right);
            }
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
            make.top.mas_equalTo(0);
        }];
        
        for (int j=0; j<self.itemsNumOnPage; j++) {
            NSDictionary* dic = array[index];
            UIButton* btn = [[UIButton alloc]init];
            btn.tag = index;
            [btn addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView* imgV = [[UIImageView alloc]init];
            if ([dic[@"image"] hasPrefix:@"http"]) {
                [imgV sd_setImageWithURL:dic[@"image"]];
            } else {
                imgV.image = [UIImage imageNamed: dic[@"image"]];
            }
            imgV.contentMode = UIViewContentModeScaleAspectFit;
            [btn addSubview:imgV];
            [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn);
                make.top.mas_equalTo(2);
                make.height.mas_equalTo(btn.mas_height).multipliedBy(0.7);
                make.width.mas_equalTo(btn);
            }];
            UILabel* label = [[UILabel alloc]init];
            label.text = dic[@"text"];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn);
                make.bottom.mas_equalTo(-2);
                make.height.mas_equalTo(btn.mas_height).multipliedBy(0.3);
                make.width.mas_equalTo(btn);
            }];
            
            [view addSubview:btn];
            [self.arrayButtons addObject:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(view.mas_width).multipliedBy(1.0/(self.itemsNumOnPage/2.0));
                make.height.mas_equalTo(view.mas_height).multipliedBy(0.5);
                CGFloat fx = (j%(self.itemsNumOnPage/2))/(self.itemsNumOnPage/2.0);
                if (fx == 0) {
                    make.left.mas_equalTo(0);
                } else {
                    make.left.mas_equalTo(view.mas_right).multipliedBy(fx);
                }
                CGFloat fy = j/(self.itemsNumOnPage/2)/2.0;
                if (fy == 0) {
                    make.top.mas_equalTo(0);
                } else {
                    make.top.mas_equalTo(view.mas_bottom).multipliedBy(fy);
                }
            }];
            index++;
            if (index>=array.count) {
                break;
            }
        }
        tempView = view;
        if (index>=array.count) {
            break;
        }
    }
    [self.contentView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.right.mas_equalTo(tempView.mas_right);
    }];
}

- (void)onClickButton:(UIButton*)btn {
    if ([_zlDelegate respondsToSelector:@selector(onClickScrollButton:index:)]) {
        [_zlDelegate onClickScrollButton:self index:btn.tag];
    }
}

- (UIButton*)getButtonByIndex:(NSInteger)index {
    return self.arrayButtons[index];
}

- (UIView*)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _contentView;
}

@end
