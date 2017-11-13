//
//  CCOrderModel.m
//  RACComand
//
//  Created by 贺彦文 on 2017/11/13.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import "CCOrderModel.h"

@implementation CCOrderModel
+ (instancetype)orderWith:(NSDictionary *)dict {
    CCOrderModel *orderOrder = [CCOrderModel new];
    orderOrder.time = dict[@"time"];
    orderOrder.startAddress = dict[@"startAddress"];
    orderOrder.endAddress = dict[@"endAddress"];
    orderOrder.billPrice = [dict[@"billPrice"] doubleValue];
    orderOrder.selected = NO;
    return orderOrder;
}
- (NSString *)price {
    return [NSString stringWithFormat:@"%.2f元", self.billPrice];
}
@end
