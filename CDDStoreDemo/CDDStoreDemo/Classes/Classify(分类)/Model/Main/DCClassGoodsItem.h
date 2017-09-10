//
//  DCClassGoodsItem.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCClassGoodsItem : NSObject

@property (nonatomic, copy ,readonly) NSString *icon;

@property (nonatomic, copy ,readonly) NSString *id;

@property (nonatomic, copy ,readonly) NSString *name;

@property (nonatomic, copy ,readonly) NSString *sort;

@property (nonatomic, copy ,readonly) NSString *status;

/* 右边数据 */
@property (strong , nonatomic) NSMutableArray<DCGoodItem *> *mainItem;
@property (assign , nonatomic) NSInteger pageIndex;

@end
