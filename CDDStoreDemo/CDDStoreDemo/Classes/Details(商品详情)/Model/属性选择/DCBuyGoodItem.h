//
//  DCBuyGoodItem.h
//  CDDStoreDemo
//
//  Created by sam on 2017/9/10.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCBuyGoodItem : NSObject

@property (strong , nonatomic)NSString *cost;
@property (strong , nonatomic)NSString *gid;
@property (strong , nonatomic)NSString *id;
@property (strong , nonatomic)NSString *item_url;
@property (strong , nonatomic)NSString *price;
@property (strong , nonatomic)NSString *sale;
@property (strong , nonatomic)NSString *stock;


@property (copy ,nonatomic) NSString *info;
@end
