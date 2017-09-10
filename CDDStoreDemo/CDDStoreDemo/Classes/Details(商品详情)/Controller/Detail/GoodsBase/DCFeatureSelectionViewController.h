//
//  DCFeatureSelectionViewController.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCFeatureItem.h"

@interface DCFeatureSelectionViewController : UIViewController


@property (strong, nonatomic) DCGoodItem *goodItem;
@property (strong, nonatomic) NSMutableArray <DCFeatureItem *> *featureAttr;


/* 上一次选择的属性 */
@property (strong , nonatomic)NSArray *lastSeleArray;
/* 上一次选择的数量 */
@property (assign , nonatomic)NSInteger lastNum;

/** 选择的属性和数量 */
@property (nonatomic , copy) void(^userChooseBlock)(NSMutableArray *seleArray,NSInteger num,NSInteger tag);

@end
