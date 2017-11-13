//
//  UITableView+RACCommandSupport.m
//  test
//
//  Created by 贺彦文 on 2017/10/25.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import "UITableView+RACCommandSupport.h"
#import <MJRefresh.h>
#import "RACEXTKeyPathCoding.h"
#import "RACCommand.h"
#import "RACDisposable.h"
#import "RACSignal+Operations.h"
#import <objc/runtime.h>

static void *UITableViewRACRefreshCommandKey = &UITableViewRACRefreshCommandKey;
static void *UITableViewRACDropCommandKey = &UITableViewRACDropCommandKey;

@implementation UITableView (RACCommandSupport)

- (RACCommand *)rac_Refreshcommand {
    return objc_getAssociatedObject(self, UITableViewRACRefreshCommandKey);
}

- (void)setRac_Refreshcommand:(RACCommand *)command {
    objc_setAssociatedObject(self, UITableViewRACRefreshCommandKey, command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (command == nil) return;
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(self) self = weakSelf;
        [command execute:self];
    }];
}

- (RACCommand *)rac_Dropcommand {
    return objc_getAssociatedObject(self, UITableViewRACDropCommandKey);
}

- (void)setRac_Dropcommand:(RACCommand *)command {
    objc_setAssociatedObject(self, UITableViewRACDropCommandKey, command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (command == nil) return;
    __weak typeof(self) weakSelf = self;
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(self) self = weakSelf;
        [command execute:self];
    }];
}
@end



