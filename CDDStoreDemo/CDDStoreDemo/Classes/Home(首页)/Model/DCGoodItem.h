//
//  DCGoodItem.h
//  CDDStoreDemo
//
//  Created by sam on 2017/9/9.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCGoodItem : NSObject


@property (nonatomic, copy ,readonly) NSString *detail;

@property (nonatomic, copy ,readonly) NSString *detail_imgs;
@property (nonatomic, copy ,readonly) NSString *freight;

@property (nonatomic, copy ,readonly) NSString *id;
@property (nonatomic, copy ,readonly) NSString *shuffling;

@property (nonatomic, copy ,readonly) NSString *is_shuffling;
@property (nonatomic, copy ,readonly) NSString *json;

@property (nonatomic, copy ,readonly) NSString *main_imgs;
@property (nonatomic, copy ,readonly) NSString *price;

@property (nonatomic, copy ,readonly) NSString *purchases;
@property (nonatomic, copy ,readonly) NSString *title;

@property (nonatomic, copy ,readonly) NSString *total_stock;

@end
