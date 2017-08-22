//
//  DC_TypeView.m
//  CDDStoreDemo
//
//  Created by sam on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DC_TypeView.h"


@interface DC_TypeView()

@property (nonatomic, strong) UIImageView *checkImgV;
@property (nonatomic, strong) UILabel *titleLab;

@end


@implementation DC_TypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    [self setUp];
    return self;
}

- (void)setUp{
    
    self.checkImgV = [UIImageView new];
    self.checkImgV.image = [UIImage imageNamed:@"打钩"];
    [self addSubview:self.checkImgV];
    
    self.titleLab = [UILabel new];
    self.titleLab.font = PFR10Font;
    [self addSubview:self.titleLab];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.checkImgV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.checkImgV.mas_right).offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

- (void)setTitle:(NSString *)title{
    
    self.titleLab.text = title;
}

@end
