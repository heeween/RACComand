//
//  GBInvoiceListBottomView.m
//  GreenBusiness
//
//  Created by 贺彦文 on 2017/10/27.
//  Copyright © 2017年 UXing. All rights reserved.
//

#import "CCOrderBottomView.h"
#import "Masonry.h"
@interface CCOrderBottomView()
@property (nonatomic,strong) UILabel *totalPriceLabel;
@property (nonatomic,strong) UILabel *totalTravelLabel;
@property (nonatomic,strong) UIButton *nextSetpButton;
@end

@implementation CCOrderBottomView

+ (instancetype)bottomView {
    CCOrderBottomView *view = [self new];
    [view setupSubview];
    [view setShadow];
    [view subviewEnable:NO];
    return view;
}
- (void)setupSubview {
    self.backgroundColor = [UIColor whiteColor];
    self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
    [self addSubview:self.totalPriceLabel];
    [self addSubview:self.totalTravelLabel];
    [self addSubview:self.nextSetpButton];
    UILabel *infoLaberl = [UILabel new];
    infoLaberl.text = @"纸质发票满200元包邮 未满200元到付";
    infoLaberl.textColor = [UIColor lightGrayColor];
    infoLaberl.font = [UIFont systemFontOfSize:11];
    [self addSubview:infoLaberl];
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(9);
    }];
    
    [self.totalTravelLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self.totalPriceLabel);
        make.left.equalTo(self.totalPriceLabel.mas_right).offset(5);
    }];
    
    [infoLaberl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.totalPriceLabel);
        make.bottom.equalTo(self).offset(-9);
    }];
    
    [self.nextSetpButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.bottom.right.equalTo(self);
        make.width.equalTo(@110);
    }];
}
- (void)setShadow {
    self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.07].CGColor;
    self.layer.shadowRadius = 17;
    self.layer.shadowOpacity = 1;
}
- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [UILabel new];
        _totalPriceLabel.textColor = [UIColor lightGrayColor];
        _totalPriceLabel.text = @"¥0.00";
        _totalPriceLabel.font = [UIFont systemFontOfSize:18];
    }
    return _totalPriceLabel;
}
- (UILabel *)totalTravelLabel {
    if (!_totalTravelLabel) {
        _totalTravelLabel = [UILabel new];
        _totalTravelLabel.textColor = [UIColor lightGrayColor];
        _totalTravelLabel.text = @"(已选0个行程)";
        _totalTravelLabel.font = [UIFont systemFontOfSize:11];
    }
    return _totalTravelLabel;
}
- (UIButton *)nextSetpButton {
    if (!_nextSetpButton) {
        _nextSetpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextSetpButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextSetpButton.backgroundColor =  [UIColor colorWithRed:17/255.0 green:144/255.0 blue:101/255.0 alpha:1];
        _nextSetpButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nextSetpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _nextSetpButton;
}
- (void)subviewEnable:(BOOL)enable; {
    if (enable) {
        self.totalPriceLabel.textColor = [UIColor colorWithRed:17/255.0 green:144/255.0 blue:101/255.0 alpha:1];
        NSDictionary *normalAttr = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:11]};
        NSDictionary *enbleAttr = @{NSForegroundColorAttributeName:[UIColor colorWithRed:17/255.0 green:144/255.0 blue:101/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:11]};
        NSString *normalString = self.totalTravelLabel.text;
        if (normalString.length > 0) {
            NSRange start = [normalString rangeOfString:@"已选"];
            NSRange end = [normalString rangeOfString:@"个行程"];
            NSRange new = NSMakeRange(start.location + start.length, end.location - start.location - start.length);
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:normalString attributes:normalAttr];
            [attrString addAttributes:enbleAttr range:new];
            self.totalTravelLabel.attributedText = attrString;
        }
        self.nextSetpButton.backgroundColor = [UIColor colorWithRed:17/255.0 green:144/255.0 blue:101/255.0 alpha:1];
        self.nextSetpButton.enabled = YES;
        [self.nextSetpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.totalPriceLabel.textColor = [UIColor lightGrayColor];
        NSDictionary *disableAttr = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:11]};
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"(已选0个行程)" attributes:disableAttr];
        self.totalTravelLabel.attributedText = attrString;
        self.nextSetpButton.backgroundColor = [UIColor grayColor];
        self.nextSetpButton.enabled = NO;
        [self.nextSetpButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
    }
}
@end
