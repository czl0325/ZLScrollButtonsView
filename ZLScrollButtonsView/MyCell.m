//
//  MyCell.m
//  ZLScrollButtonsView
//
//  Created by qipai on 2017/12/19.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import "MyCell.h"
#import "Masonry.h"

@implementation MyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.labelNumber];
        [self.labelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel*)labelNumber {
    if (!_labelNumber) {
        _labelNumber = [UILabel new];
        _labelNumber.textColor = [UIColor redColor];
        _labelNumber.font = [UIFont boldSystemFontOfSize:20];
        _labelNumber.textAlignment = NSTextAlignmentCenter;
    }
    return _labelNumber;
}

@end
