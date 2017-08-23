//
//  DCShowTypeOneCell.m
//  CDDMall
//
//  Created by apple on 2017/6/25.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCShowTypeOneCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCShowTypeOneCell ()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation DCShowTypeOneCell

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
    
    self.imageV = [UIImageView new];
    self.imageV.backgroundColor = [UIColor blueColor];
    [self addSubview:self.imageV];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
    
}

#pragma mark - Setter Getter Methods

@end
