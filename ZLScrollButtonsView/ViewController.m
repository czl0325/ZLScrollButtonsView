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
#import "MyCell.h"
#import "ZLHorizontalFlowLayout.h"

@interface ViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource,
ZLHorizontalFlowLayoutDelegate>
{
    BOOL isChange;
    NSInteger currentPage;
    NSInteger totalPage;
}

@property(nonatomic,strong)UICollectionView* myCollectionView;
@property(nonatomic,strong)NSMutableArray* arrayDatas;
@property(nonatomic,strong)NSMutableArray* cellAttributesArray;
@property(nonatomic,strong)NSTimer* timerDrag;

@end

@implementation ViewController

#define Random(X) arc4random_uniform(X)/255.0
#define RandomColor [UIColor colorWithRed:Random(255) green:Random(255) blue:Random(255) alpha:1.0]

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i=0; i<18; i++) {
        [self.arrayDatas addObject:[NSString stringWithFormat:@"%zd",i]];
    }
    currentPage = 0;
    totalPage = self.arrayDatas.count/8;
    if (self.arrayDatas.count%8>0) {
        totalPage++;
    }
    
    ZLScrollButtonsView* zlScrollButtonsView = [ZLScrollButtonsView new];
    zlScrollButtonsView.layer.borderColor = [UIColor blackColor].CGColor;
    zlScrollButtonsView.layer.borderWidth = 0.5f;
    [self.view addSubview:zlScrollButtonsView];
    [zlScrollButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(200);
    }];
    
    [self.view addSubview:self.myCollectionView];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(zlScrollButtonsView.mas_bottom).offset(10);
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayDatas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = RandomColor;
    cell.labelNumber.text = self.arrayDatas[indexPath.item];
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath  {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    [self.arrayDatas removeObjectAtIndex:sourceIndexPath.item];
    NSString* str = self.arrayDatas[sourceIndexPath.item];
    [self.arrayDatas insertObject:str atIndex:destinationIndexPath.item];
}

- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        ZLHorizontalFlowLayout *viewFlowLayout = [[ZLHorizontalFlowLayout alloc] init];
        viewFlowLayout.delegate = self;
        viewFlowLayout.minimumLineSpacing = 5;
        viewFlowLayout.minimumInteritemSpacing = 5;
        viewFlowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:viewFlowLayout];
        _myCollectionView.showsHorizontalScrollIndicator = NO; // 去掉滚动条
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.alwaysBounceHorizontal = YES;
        _myCollectionView.pagingEnabled = YES;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"MyCell"];
        //[_myCollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _myCollectionView;
}

- (NSMutableArray*)arrayDatas {
    if (!_arrayDatas) {
        _arrayDatas = [NSMutableArray new];
    }
    return _arrayDatas;
}

- (NSMutableArray*)cellAttributesArray {
    if (!_cellAttributesArray) {
        _cellAttributesArray = [NSMutableArray new];
    }
    return _cellAttributesArray;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
//    switch (longPress.state) {
//        case UIGestureRecognizerStateBegan:
//        { //手势开始
//            //判断手势落点位置是否在row上
//            NSIndexPath *indexPath = [self.myCollectionView indexPathForItemAtPoint:[longPress locationInView:self.myCollectionView]];
//            if (indexPath == nil) {
//                break;
//            }
//            UICollectionViewCell *cell = [self.myCollectionView cellForItemAtIndexPath:indexPath];
//            [self.view bringSubviewToFront:cell];
//            //iOS9方法 移动cell
//            [self.myCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//        { // 手势改变
//            // iOS9方法 移动过程中随时更新cell位置
//            [self.myCollectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.myCollectionView]];
//        }
//            break;
//        case UIGestureRecognizerStateEnded:
//        { // 手势结束
//            // iOS9方法 移动结束后关闭cell移动
//            [self.myCollectionView endInteractiveMovement];
//        }
//            break;
//        default: //手势其他状态
//            [self.myCollectionView cancelInteractiveMovement];
//            break;
//    }
//    return;
    //获取当前cell所对应的indexpath
    MyCell *cell = (MyCell *)longPress.view;
    NSIndexPath *cellIndexpath = [self.myCollectionView indexPathForCell:cell];
    
    //将此cell 移动到视图的前面
    [self.myCollectionView bringSubviewToFront:cell];
    isChange = NO;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            //使用数组将collectionView每个cell的 UICollectionViewLayoutAttributes 存储起来。
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.arrayDatas.count; i++) {
                [self.cellAttributesArray addObject:[self.myCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            //在移动过程中，使cell的中心与移动的位置相同。
            cell.center = [longPress locationInView:self.myCollectionView];
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                //判断移动cell的indexpath，是否和目的位置相同，如果相同isChange为YES,然后将数据源交换
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    isChange = YES;
                    NSString *imgStr = self.arrayDatas[cellIndexpath.row];
                    [self.arrayDatas removeObjectAtIndex:cellIndexpath.row];
                    [self.arrayDatas insertObject:imgStr atIndex:attributes.indexPath.row];
                    [self.myCollectionView moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                }
            }
            if ((cell.center.x + cell.frame.size.width/4) > self.myCollectionView.frame.size.width) {
                if (currentPage < totalPage-1) {
                    if (self.timerDrag) {
                        
                    } else {
                        [self.myCollectionView setContentOffset:CGPointMake((currentPage+1)*self.myCollectionView.frame.size.width, 0) animated:YES];
                        currentPage = currentPage + 1;
                        if (self.timerDrag == nil) {
                            self.timerDrag = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(waitPageChange) userInfo:nil repeats:NO];
                        }
                    }
                }
            }
            if ((cell.center.x - cell.frame.size.width/4) < 0) {
                if (currentPage > 0) {
                    if (self.timerDrag) {
                        
                    } else {
                        [self.myCollectionView setContentOffset:CGPointMake((currentPage-1)*self.myCollectionView.frame.size.width, 0) animated:YES];
                        currentPage = currentPage - 1;
                        if (self.timerDrag == nil) {
                            self.timerDrag = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(waitPageChange) userInfo:nil repeats:NO];
                        }
                    }
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            //如果没有改变，直接返回原始位置
            if (!isChange) {
                cell.center = [self.myCollectionView layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
        }
            break;
        default:
            break;
    }
}

- (void)waitPageChange {
    [self.timerDrag invalidate];
    self.timerDrag = nil;
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page {
    currentPage = page;
}

@end
