//
//  UIViewController+DCHud.h
//  CDDStoreDemo
//
//  Created by sam on 2017/9/9.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface UIViewController (DCHud)

- (void)showHUD;
- (void)hideHUD;
- (void)showTipWithStr:(NSString *)str;

@end
