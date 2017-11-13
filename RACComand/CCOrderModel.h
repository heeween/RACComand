//
//  CCOrderModel.h
//  RACComand
//
//  Created by 贺彦文 on 2017/11/13.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCOrderModel : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *startAddress;
@property (nonatomic,copy) NSString *endAddress;
@property (nonatomic,assign) double billPrice;
@property (nonatomic,copy,readonly) NSString *price;
@property (nonatomic,assign) BOOL selected;
+ (instancetype)orderWith:(NSDictionary *)dict;
@end
