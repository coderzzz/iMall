//
//  AppDelegate.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "AppDelegate.h"
#import "JKDBModel.h"
#import "DCTabBarController.h"
#import "BRLoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    DCUserInfo *userInfo = UserInfoData;
    if (userInfo.phone.length>0) {
        
         self.window.rootViewController = [[DCTabBarController alloc] init];
    }
    else{
        
        BRLoginViewController *vc = [BRLoginViewController new];
        DCNavigationController *nav = [[DCNavigationController alloc]initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }
   
    
    [self.window makeKeyAndVisible];
    
//    [self setUpUserData]; //设置数据
    
    /* 设置友盟appkey */
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"599bf1ce82b63512ed00036d"];
    
    [self configUSharePlatforms];
    
//    [self confitUShareSettings];
    
    return YES;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxd2adeee83b0f9771" appSecret:@"aa8a862d105dadc32a524b17b8d30a5f" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /*
//     设置新浪的appKey和appSecret
//     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

/**
 是否登录
 */
- (void)setUpUserData
{
    DCUserInfo *userInfo = UserInfoData;
    if (userInfo.username.length == 0) { //userName为指定id不可改动用来判断是否有用户数据
        DCUserInfo *userInfo = [[DCUserInfo alloc] init];
//        userInfo.nickname = @"RocketsChen";
//        userInfo.sex = @"男";
//        userInfo.birthDay = @"1996-02-10";
//        userInfo.userimage = @"icon";
//        userInfo.username = @"qq-w923740293";
//        userInfo.defaultAddress = @"江苏 苏州吴中";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{//异步保存
            [userInfo save];
        });
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
