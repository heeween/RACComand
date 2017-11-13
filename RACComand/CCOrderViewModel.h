//
//  CCOrderViewModel.h
//  RACComand
//
//  Created by 贺彦文 on 2017/11/13.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand,RACSignal,RACTuple,CCOrderModel;
@interface CCOrderViewModel : NSObject

@property (nonatomic,strong) NSMutableArray <CCOrderModel *>*orderArray;
// 下拉信号的创建和command输入
@property (nonatomic,strong) RACCommand *refreashCmd;
// 上拉信号的创建和command输入
@property (nonatomic,strong) RACCommand *loadMoreCmd;
// 上拉和下拉两个信号统一输出
@property (nonatomic,strong) RACSignal *reloadTableViewSignal;
// 返回值有4个:(1,选中个数;2,选中价格;3,选中的ID;4,是否未选中)
- (RACTuple *)selectedOrders;
@end
