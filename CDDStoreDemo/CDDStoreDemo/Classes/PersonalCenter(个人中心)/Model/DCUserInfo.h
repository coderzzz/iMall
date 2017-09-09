//
//  DCUserInfo.h
//  CDDMall
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "JKDBModel.h"

@interface DCUserInfo : JKDBModel


@property (nonatomic, copy) NSString *open_id;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *register_type;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *userimage;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *school;

@end
