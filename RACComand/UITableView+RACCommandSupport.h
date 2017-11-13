//
//  UITableView+RACCommandSupport.h
//  test
//
//  Created by 贺彦文 on 2017/10/25.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACCommand;
@interface UITableView (RACCommandSupport)
@property (nonatomic, strong) RACCommand *rac_Refreshcommand;
@property (nonatomic, strong) RACCommand *rac_Dropcommand;
@end
