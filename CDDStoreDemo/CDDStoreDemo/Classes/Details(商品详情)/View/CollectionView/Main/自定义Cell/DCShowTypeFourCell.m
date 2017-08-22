//
//  DCShowTypeFourCell.m
//  CDDMall
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCShowTypeFourCell.h"
#import "DC_TypeView.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCShowTypeFourCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) DC_TypeView *type1;
@property (nonatomic, strong) DC_TypeView *type2;
@property (nonatomic, strong) DC_TypeView *type3;

@end

@implementation DCShowTypeFourCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}

- (void)setUpData
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.bgView = [UIView new];
    self.bgView.backgroundColor = HEXCOLOR(0xf3f3f3);
    [self.contentView addSubview:self.bgView];
    
    _type1 = [[DC_TypeView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    _type1.title = @"7天退货";
    [self.contentView addSubview:_type1];
    
    _type2 = [[DC_TypeView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    _type2.title = @"正品保证";
    [self.contentView addSubview:_type2];
    
    _type3 = [[DC_TypeView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    _type3.title = @"48小时发货";
    [self.contentView addSubview:_type3];
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(DCMargin);
        make.right.equalTo(self).offset(-DCMargin);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.type1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.bgView).offset(DCMargin);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.offset(50);
    }];
   
    [self.type2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.type1.mas_right).offset(DCMargin + 8);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.offset(50);
    }];
    
    [self.type3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.type2.mas_right).offset(DCMargin + 8);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.offset(50);
    }];
}

#pragma mark - Setter Getter Methods

@end
