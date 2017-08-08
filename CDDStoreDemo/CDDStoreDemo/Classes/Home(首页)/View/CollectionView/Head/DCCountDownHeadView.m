//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCountDownHeadView.h"

// Controllers

// Models

// Views
#import "DCZuoWenRightButton.h"
// Vendors

// Categories

// Others

@interface DCCountDownHeadView ()


/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;

/* 好货秒抢 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DCCountDownHeadView

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

//    _countDownLabel = [[UILabel alloc] init];
//    _countDownLabel.backgroundColor = DCBGColor;
//    [self addSubview:_countDownLabel];
    
    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = PFR16Font;

//    [_quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:UIControlStateNormal];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:_quickButton];

}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
//    _countDownLabel.frame = CGRectMake(0, 0, self.dc_width, 5);
    [_quickButton setTitle:self.title forState:UIControlStateNormal];
    _quickButton.frame = CGRectMake((self.dc_width - 150)/2, 0, 150, self.dc_height);
    
}


#pragma mark - Setter Getter Methods


@end
