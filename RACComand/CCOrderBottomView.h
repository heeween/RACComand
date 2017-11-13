//
//  GBInvoiceListBottomView.h
//  GreenBusiness
//
//  Created by 贺彦文 on 2017/10/27.
//  Copyright © 2017年 UXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCOrderBottomView : UIView
@property (nonatomic,strong,readonly) UILabel *totalPriceLabel;
@property (nonatomic,strong,readonly) UILabel *totalTravelLabel;
@property (nonatomic,strong,readonly) UIButton *nextSetpButton;

+ (instancetype)bottomView;
- (void)subviewEnable:(BOOL)enable;
@end
