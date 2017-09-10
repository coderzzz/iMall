//
//  DCFeatureList.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCFeatureList : NSObject

/** 类型名 */
@property (nonatomic, copy) NSString *id;
/** 额外价格 */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *spec_id;
/** 额外价格 */
@property (nonatomic, copy) NSString *spec_name;

//
///** 类型名 */
//@property (nonatomic, copy) NSString *infoname;
///** 额外价格 */
//@property (nonatomic, copy) NSString *plusprice;



/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end
