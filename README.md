# ZLScrollButtonsView
图标列表的滚动视图

模仿苹果手机屏幕上app图标的拖动，切换页面。demo还不完善（如果有朋友有优化的方法，可以交流）


![](https://github.com/czl0325/ZLScrollButtonsView/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE.gif?raw=true)


用法如下：

详见demo

代码如下：

```Objective-C
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
```