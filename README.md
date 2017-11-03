# ZLScrollButtonsView
图标列表的滚动视图

我做的一个按钮列表滚动视图，支持autolayout布局，支持网络图片或者本地图片，原默认一页有6个按钮，可以自己设置按钮个数，行数只有上下两行，如果要多行的朋友可以修改我的源代码自己定制。


![](https://github.com/czl0325/ZLScrollButtonsView/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE.gif?raw=true)


用法如下：
首先导入#import "ZLScrollButtonsView.h"

用的时候需要传入一个数组，数组为字典类型，key有两个，一个是image，可以为本地的图片名称或者网络图片名称，我在里面有做判断，需要用sdwebimage这个库，还有一个是text，就是按钮的文本.
代码如下：

```Objective-C
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
```