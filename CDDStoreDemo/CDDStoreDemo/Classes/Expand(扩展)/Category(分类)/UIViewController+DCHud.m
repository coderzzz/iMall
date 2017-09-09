//
//  UIViewController+DCHud.m
//  CDDStoreDemo
//
//  Created by sam on 2017/9/9.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "UIViewController+DCHud.h"
#import "AppDelegate.h"
@implementation UIViewController (DCHud)

- (void)showHUD{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    
}

- (void)hideHUD{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD hideAllHUDsForView:delegate.window animated:NO];
}

- (void)showTipWithStr:(NSString *)str{
    
    [self hideHUD];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = str;
    [hud hide:YES afterDelay:2];
}
@end
