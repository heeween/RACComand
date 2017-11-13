//
//  ViewController.m
//  RACComand
//
//  Created by 贺彦文 on 2017/11/13.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import "ViewController.h"
#import "CCOrderCell.h"
#import "CCOrderViewModel.h"
#import "CCOrderModel.h"
#import "CCOrderBottomView.h"
#import "UITableView+RACCommandSupport.h"
#import "ReactiveCocoa.h"
#import "MJRefresh.h"
#import "Masonry.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CCOrderViewModel *viewModel;
@property (nonatomic,strong) CCOrderBottomView *bottomView;
@end

static NSString *ccOrderCell = @"ccOrderCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"曹操专车";
    [self bindViewModel];
    [self setupUI];
}

- (void)bindViewModel {
    // command绑定
    self.tableView.rac_Refreshcommand = self.viewModel.refreashCmd;
    self.tableView.rac_Dropcommand = self.viewModel.loadMoreCmd;
    
    [self rac_liftSelector:@selector(reloadTableView:) withSignals:self.viewModel.reloadTableViewSignal, nil];
    
    // 默认先执行refreshCmd
    [self.viewModel.refreashCmd execute:nil];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:CCOrderCell.class forCellReuseIdentifier:ccOrderCell];
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = 20;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
}

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
#pragma mark - UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.orderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ccOrderCell];
    CCOrderModel *model = [self.viewModel.orderArray objectAtIndex:indexPath.row];
    cell.timeLabel.text = model.time;
    cell.startAddressLabel.text = model.startAddress;
    cell.endAddressLabel.text = model.endAddress;
    cell.priceLabel.text = model.price;
    cell.selectButton.selected = model.selected;
    cell.bottomWholeLineView.hidden = indexPath.row == self.viewModel.orderArray.count - 1;
    // 根据indexpath重新绑定cell中button点击信号
    RACSignal *touchSignal = [[cell.selectButton
                               rac_signalForControlEvents:UIControlEventTouchUpInside]
                              takeUntil:cell.rac_prepareForReuseSignal];
    RACSignal *touchIndexPathSignal = [[touchSignal map:^id(id value) { return indexPath; }]
                                       doNext:^(id x) { model.selected = !model.selected; }];
    [self rac_liftSelector:@selector(reloadTableView:) withSignals:touchIndexPathSignal, nil];
    return cell;
}

#pragma mark - Other Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSIndexPath *indexPath = (NSIndexPath *)x;
    CCOrderModel *model = [self.viewModel.orderArray objectAtIndex:indexPath.row];
    
    model.selected = !model.selected;
    [self reloadTableView:nil];
}

#pragma mark - Lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]  init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }
    return _tableView;
}
- (CCOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [CCOrderViewModel new];
    }
    return _viewModel;
}
- (CCOrderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [CCOrderBottomView bottomView];
    }
    return _bottomView;
}
@end
