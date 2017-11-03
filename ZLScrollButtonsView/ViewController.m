//
//  ViewController.m
//  ZLScrollButtonsView
//
//  Created by zhaoliang chen on 2017/10/30.
//  Copyright © 2017年 zhaoliang chen. All rights reserved.
//

#import "ViewController.h"
#import "ZLScrollButtonsView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZLScrollButtonsView* zlScrollButtonsView = [ZLScrollButtonsView new];
    zlScrollButtonsView.layer.borderColor = [UIColor blackColor].CGColor;
    zlScrollButtonsView.layer.borderWidth = 0.5f;
    [self.view addSubview:zlScrollButtonsView];
    [zlScrollButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
    
    NSMutableArray* array = [NSMutableArray new];
    for (int i=0; i<8; i++) {
        [array addObject:@{@"text":[NSString stringWithFormat:@"图标%zd",i+1],@"image":[NSString stringWithFormat:@"image%zd",i+1]}];
    }
    [zlScrollButtonsView reloadScrllButtons:array];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
