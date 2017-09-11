//
//  DCGoodItem.h
//  CDDStoreDemo
//
//  Created by sam on 2017/9/9.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCGoodItem : NSObject


@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *detail_imgs;
@property (nonatomic, copy) NSString *freight;

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *iid;
@property (nonatomic, copy) NSString *shuffling;

@property (nonatomic, copy) NSString *is_shuffling;
@property (nonatomic, copy ,readonly) NSString *json;

@property (nonatomic, copy) NSString *main_imgs;
@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *purchases;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *total_stock;
@property (nonatomic, copy) NSString *uuid;


@property (nonatomic, copy ) NSString *is_collection;
@property (nonatomic, copy ) NSArray *spec_info;



//

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) int  count;
@end
