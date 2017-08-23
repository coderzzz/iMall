//
//  DCDetailLikeHeadView.m
//  CDDStoreDemo
//
//  Created by sam on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailLikeHeadView.h"

@implementation DCDetailLikeHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = PFR14Font;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"为你推荐";
        [self addSubview:lab];
    }
    return self;
}

@end
