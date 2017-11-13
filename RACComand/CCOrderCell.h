//
//  CCOrderCell.h
//  RACComand
//
//  Created by 贺彦文 on 2017/11/13.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCOrderCell : UITableViewCell
@property (nonatomic,strong,readonly) UIView *bottomWholeLineView;
@property (nonatomic,strong,readonly) UIButton *selectButton;
@property (nonatomic,strong,readonly) UILabel *timeLabel;
@property (nonatomic,strong,readonly) UILabel *startAddressLabel;
@property (nonatomic,strong,readonly) UILabel *endAddressLabel;
@property (nonatomic,strong,readonly) UILabel *priceLabel;
@end
