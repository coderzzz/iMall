//
//  DCDetailLikeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailLikeCell.h"

@interface DCDetailLikeCell ()

@property (nonatomic, strong) UIImageView *imgv;
@property (nonatomic, strong) UILabel *titleLab;


@end



@implementation DCDetailLikeCell

#pragma mark - lazyload


#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}


- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.imgv = [UIImageView new];
    [self addSubview:self.imgv];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = PFR16Font;
    [self addSubview:self.titleLab];
    
}



#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgv.backgroundColor = [UIColor yellowColor];
    [self.imgv mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(DCMargin);
        make.right.equalTo(self).offset(-DCMargin);
        make.top.equalTo(self).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-30);
    }];
    
    self.titleLab.text = @"韩国文具笔记本";
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.imgv);
        make.top.mas_equalTo(self.imgv.mas_bottom).offset(5);
        make.right.equalTo(self.imgv);
    }];
}


@end
