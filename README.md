# 界面如下
 * 上拉加载更多 下拉刷新
 * 点击按钮选择 底部view根据选择情况作出响应
* 案例代码https://git.coding.net/codingheew/RACComand.git
https://github.com/heeween/RACComand.git
![ReactiveCocoa用法示例(一).gif](http://upload-images.jianshu.io/upload_images/661867-c758b690b46429cc.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


# RACComand与TableView刷新事件绑定
* 写UITableView支持RACComand事件绑定的分类
```objc
// UITableView+RACCommandSupport.m 文件中代码
- (void)setRac_Refreshcommand:(RACCommand *)command {
    objc_setAssociatedObject(self, UITableViewRACRefreshCommandKey, command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (command == nil) return;
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(self) self = weakSelf;
        [command execute:self];
    }];
}
```
> 这里的分类主要就是给Tableview增加MJRefresh,并且将传入command参数传入MJRefresh执行的block中
* viewmodel中定义刷新和加载更多的事件
```objc
//CCOrderViewModel.m 文件中代码
    NSArray *array = @[
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"瑞立东方花城",@"billPrice":@241.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"杭州滨江区星光大道",@"billPrice":@21.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"杭杭州萧山国际机场",@"billPrice":@10.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"红石中央大厦",@"billPrice":@19.24},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"杭州半山国家森林公园",@"billPrice":@2.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"瑞立东方花城",@"billPrice":@15.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"瑞立东方花城",@"billPrice":@241.00},];
    NSMutableArray *modelArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [modelArray addObject:[CCOrderModel orderWith:obj]];
    }];
    @weakify(self);
    self.refreashCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self.orderArray removeAllObjects];
            [self.orderArray addObjectsFromArray:modelArray];
            [subscriber sendNext:self.orderArray];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    self.loadMoreCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self.orderArray addObjectsFromArray:modelArray];
            [subscriber sendNext:self.orderArray];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
```
> 这里定义两个command,将数据包在signal中,再包在command中
* 控制器中将viewmode的command事件和UItableview绑定
 控制器中的绑定就非常简单,这样绑定之后,tableview的刷新事件就会进入viewmodel的command的block中
```objc
    // ViewController.m 文件中代码 command绑定
    self.tableView.rac_Refreshcommand = self.viewModel.refreashCmd;
    self.tableView.rac_Dropcommand = self.viewModel.loadMoreCmd;
```

* 给viewmodel添加两个刷新事件组合之后的,tableview刷新signal
目的是在控制器,只需要监听viewmodel的一个signal,可以统一刷新tableview
```objc
  //CCOrderViewModel.m 文件中代码
    RACSignal *refreshEndSignal = [[self.refreashCmd executionSignals] switchToLatest];
    RACSignal *loadmoreEndSignal = [[self.loadMoreCmd executionSignals] switchToLatest];
    // 上拉和下拉两个信号统一输出
    self.reloadTableViewSignal = [RACSignal merge:@[refreshEndSignal, loadmoreEndSignal]];
```
* 控制器绑定Signal的代码
这里是利用rac_liftSelector将viewmodel刷新signal直接和控制器的reloadTableView:绑定
```objc
    // ViewController.m 文件中代码
    [self rac_liftSelector:@selector(reloadTableView:) withSignals:self.viewModel.reloadTableViewSignal, nil];

/** 刷新列表 */
- (void)reloadTableView:(id)obj {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
    NSString *numberString = self.viewModel.selectedOrders.first;
    NSString *priceString = self.viewModel.selectedOrders.second;
    BOOL enable = [self.viewModel.selectedOrders.third boolValue];
    self.bottomView.totalPriceLabel.text = priceString;
    self.bottomView.totalTravelLabel.text = numberString;
    [self.bottomView subviewEnable:enable];
}
```
* 其他cell赋值就很简单了
在这里我说下我对cell创建的理解,我认为cell不应该持有model.cell赋值就通过暴露出来的UI控件在控制器中赋值就好了.这样cell是一个很纯净的cell.没有任何逻辑.内聚性很强.逻辑方面的bug也绝对不需要去cell中找.
MVVM的架构模式,就是极大的提高viewmodel层逻辑代码的内聚性,使得UI代码和业务代码完全隔离,维护的时候很专心的去对应的文件找问题就可以了.通过事件绑定在控制器中.极大的简化控制器,控制器只存在业务代码的调度,非常方便找到对应的业务代码.