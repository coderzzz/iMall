//
//  DCGoodsHandheldCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsHandheldCell.h"

// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others


@interface DCGoodsHandheldCell ()

/* 图片 */
@property (strong, nonatomic)UIImageView *handheldImageView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *subTitleLabel;

@end

@implementation DCGoodsHandheldCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _handheldImageView = [[UIImageView alloc] init];
    _handheldImageView.layer.masksToBounds = YES;
    _handheldImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs8.gomein.net.cn/T1TkDvBK_j1RCvBVdK.jpg"]];

    [self addSubview:_handheldImageView];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"睡眠遮光罩";
    _titleLabel.font = PFR15Font;
    _titleLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_titleLabel];
    
    _subTitleLabel = [UILabel new];
    _subTitleLabel.text = @"适合学生";
    _subTitleLabel.font = PFR14Font;
    _subTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_subTitleLabel];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(-80);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_handheldImageView.mas_bottom);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self);
        make.height.offset(40);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(-5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self);
        make.height.offset(12);
    }];
    
    
    
}

#pragma mark - Setter Getter Methods
- (void)setGoodItem:(DCGoodItem *)goodItem
{
    _goodItem = goodItem;
    
    [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:goodItem.main_imgs]];
    _titleLabel.text = goodItem.title;
    _subTitleLabel.text = goodItem.detail;
}

@end
