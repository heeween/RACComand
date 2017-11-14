//
//  CCOrderViewModel.m
//  RACComand
//
//  Created by 贺彦文 on 2017/11/13.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import "CCOrderViewModel.h"
#import "RACCommand.h"
#import "RACSignal.h"
#import "RACEXTScope.h"
#import "RACSubscriber.h"
#import "ReactiveCocoa.h"
#import "CCOrderModel.h"

@implementation CCOrderViewModel
- (instancetype)init
{
    if (self = [super init]) {
        [self setupRACCommand];
    }
    return self;
}
- (void)setupRACCommand
{
    NSArray *array = @[
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"瑞立东方花城",@"billPrice":@241.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"杭州滨江区星光大道",@"billPrice":@21.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"杭杭州萧山国际机场",@"billPrice":@10.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"红石中央大厦",@"billPrice":@19.24},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"杭州半山国家森林公园",@"billPrice":@2.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"瑞立东方花城",@"billPrice":@15.00},
                       @{@"time":@"今天 17:00",@"startAddress":@"浙江吉利控股集团有限公司",@"endAddress":@"瑞立东方花城",@"billPrice":@241.00},];

    @weakify(self);
    self.refreashCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            NSMutableArray *modelArray = [NSMutableArray array];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [modelArray addObject:[CCOrderModel orderWith:obj]];
            }];
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
            NSMutableArray *modelArray = [NSMutableArray array];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [modelArray addObject:[CCOrderModel orderWith:obj]];
            }];
            [self.orderArray addObjectsFromArray:modelArray];
            [subscriber sendNext:self.orderArray];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    RACSignal *refreshEndSignal = [[self.refreashCmd executionSignals] switchToLatest];
    RACSignal *loadmoreEndSignal = [[self.loadMoreCmd executionSignals] switchToLatest];
    // 上拉和下拉两个信号统一输出
    self.reloadTableViewSignal = [RACSignal merge:@[refreshEndSignal, loadmoreEndSignal]];
    
}
#pragma mark - geter
- (RACTuple *)selectedOrders {
    __block NSInteger number = 0;
    __block float price = 0.f;
    [self.orderArray enumerateObjectsUsingBlock:^(CCOrderModel * _Nonnull cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (cellModel.selected) {
            number++;
            price += cellModel.billPrice;
        }
    }];
    NSString *numberString = [NSString stringWithFormat:@"(已选%ld个行程)",(long)number];
    NSString *priceString = [NSString stringWithFormat:@"%.2f元", price];
    BOOL enable = number > 0;
    return RACTuplePack(numberString,priceString,@(enable),nil);
}

- (NSMutableArray *)orderArray {
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
@end
