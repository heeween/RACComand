//
//  CCOrderCell.m
//  RACComand
//
//  Created by 贺彦文 on 2017/11/13.
//  Copyright © 2017年 caocao. All rights reserved.
//

#import "CCOrderCell.h"
#import "Masonry.h"

@interface CCOrderCell()

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIImageView *timeImageView;
@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *startAddressLabel;
@property (nonatomic,strong) UILabel *endAddressLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIView *bottomWholeLineView;
@property (nonatomic,strong) UIImageView *startIconImageView;
@property (nonatomic,strong) UIImageView *endIconImageView;
@end

@implementation CCOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self uiInit];
    }
    return self;
}

- (void)uiInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.timeImageView];
    [self.containerView addSubview:self.timeLabel];
    [self.containerView addSubview:self.startIconImageView];
    [self.containerView addSubview:self.endIconImageView];
    [self.containerView addSubview:self.startAddressLabel];
    [self.containerView addSubview:self.endAddressLabel];
    [self.containerView addSubview:self.bottomWholeLineView];
    [self.containerView addSubview:self.selectButton];
    [self.containerView addSubview:self.priceLabel];
    [self unitsSdLayout];
}

-(void)unitsSdLayout
{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsFromString(@"{0,12,0,12}"));
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@36);
        make.left.top.bottom.equalTo(self.containerView);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@72);
        make.right.top.bottom.equalTo(self.containerView);
    }];
    
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.selectButton.mas_right).offset(4);
        make.top.equalTo(self.containerView).offset(18);
        make.width.height.equalTo(@6);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.timeImageView.mas_right).offset(10);
        make.centerY.equalTo(self.timeImageView);
        make.right.greaterThanOrEqualTo(self.priceLabel.mas_left).offset(-10);
    }];
    
    [self.startIconImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.timeImageView);
        make.width.height.equalTo(@6);
        make.top.equalTo(self.timeImageView.mas_bottom).offset(14);
    }];
    
    [self.startAddressLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.timeLabel);
        make.centerY.equalTo(self.startIconImageView);
        make.right.greaterThanOrEqualTo(self.priceLabel.mas_left).offset(-10);
    }];
    
    [self.endIconImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.timeImageView);
        make.width.height.equalTo(@6);
        make.top.equalTo(self.startIconImageView.mas_bottom).offset(18);
    }];
    
    [self.endAddressLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.timeLabel);
        make.centerY.equalTo(self.endIconImageView);
        make.right.greaterThanOrEqualTo(self.priceLabel.mas_left).offset(-10);
    }];
    
    [self.bottomWholeLineView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.containerView).offset(38);
        make.right.bottom.equalTo(self.containerView);
        make.height.equalTo(@(0.5));
    }];
    
    
    UIView *dddee1View1 = [UIView new];
    dddee1View1.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    dddee1View1.layer.cornerRadius = 1;
    dddee1View1.layer.masksToBounds = YES;
    [self.containerView addSubview:dddee1View1];
    [dddee1View1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.height.equalTo(@2);
        make.centerX.equalTo(self.timeImageView);
        make.top.equalTo(self.startIconImageView.mas_bottom).offset(3);
    }];
    
    
    UIView *dddee1View2 = [UIView new];
    dddee1View2.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    dddee1View2.layer.cornerRadius = 1;
    dddee1View2.layer.masksToBounds = YES;
    [self.containerView addSubview:dddee1View2];
    [dddee1View2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.height.equalTo(@2);
        make.centerX.equalTo(self.timeImageView);
        make.top.equalTo(dddee1View1.mas_bottom).offset(3);
    }];
    
    
    UIView *dddee1View3 = [UIView new];
    dddee1View3.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    dddee1View3.layer.cornerRadius = 1;
    dddee1View3.layer.masksToBounds = YES;
    [self.containerView addSubview:dddee1View3];
    [dddee1View3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.height.equalTo(@2);
        make.centerX.equalTo(self.timeImageView);
        make.top.equalTo(dddee1View2.mas_bottom).offset(3);
    }];
    
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:16];
        _priceLabel.textColor = [UIColor colorWithRed:17/255.0 green:144/255.0 blue:101/255.0 alpha:1];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *normalImage = [[UIImage imageNamed:@"common_radio_icon_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [UIImage imageNamed:@"common_radio_icon_select"];
        [_selectButton setImage:normalImage forState:UIControlStateNormal];
        [_selectButton setImage:selectedImage forState:UIControlStateSelected];
        _selectButton.imageEdgeInsets = UIEdgeInsetsFromString(@"{0,4.5,0,-4.5}");
    }
    return _selectButton;
}
- (UIView *)bottomWholeLineView {
    if (!_bottomWholeLineView) {
        _bottomWholeLineView = [UIView new];
        _bottomWholeLineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    }
    return _bottomWholeLineView;
}
- (UILabel *)endAddressLabel {
    if (!_endAddressLabel) {
        _endAddressLabel = [UILabel new];
        _endAddressLabel.font = [UIFont systemFontOfSize:14];
        _endAddressLabel.textColor = [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1];
        _endAddressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _endAddressLabel;
}
- (UILabel *)startAddressLabel {
    if (!_startAddressLabel) {
        _startAddressLabel = [UILabel new];
        _startAddressLabel.font = [UIFont systemFontOfSize:14];
        _startAddressLabel.textColor = [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1];
        _startAddressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _startAddressLabel;
}
- (UIImageView *)endIconImageView {
    if (!_endIconImageView) {
        _endIconImageView = [UIImageView new];
        UIImage *endIconimage = [[UIImage imageNamed:@"common_icon_map_destination"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _endIconImageView.image = endIconimage;
    }
    return _endIconImageView;
}
- (UIImageView *)startIconImageView {
    if (!_startIconImageView) {
        _startIconImageView = [UIImageView new];
        UIImage *startIconimage = [[UIImage imageNamed:@"common_icon_map_departure"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _startIconImageView.image = startIconimage;
    }
    return _startIconImageView;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"今天 11:29";
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}
- (UIImageView *)timeImageView {
    if (!_timeImageView) {
        _timeImageView = [UIImageView new];
        UIImage *timeimage = [[UIImage imageNamed:@"common_invoice_icon_clock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _timeImageView.image = timeimage;
    }
    return _timeImageView;
}
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}
@end
