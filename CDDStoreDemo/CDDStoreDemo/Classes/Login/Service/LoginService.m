//
//  LoginService.m
//  iwen
//
//  Created by Interest on 15/10/22.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LoginService.h"
//#import "AdvertiseMentModel.h"
//#import "LuanchAdvertisementModel.h"
#import <objc/runtime.h>
@implementation LoginService

+ (LoginService *)shareInstanced
{
    
    static LoginService * this = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        this = [[self alloc] init];
    });
    
    return this;

}

//- (BOOL)isLogined{
//    
//    PersonModel *model = [self getUserModel];
//    
//    if (model.use.fphone.length>0) {
//        
//        return YES;
//    }
//    
//    return NO;
//}
//
//
////
////
////
////    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
////
////    NSArray *ary = [dic allKeys];
////
////    for (int a= 0; a<ary.count; a++) {
////        
////        if (dic[ary[a]] !=[NSNull null] && dic[ary[a]] !=nil) {
////            
////            [userDefaults setObject:dic[ary[a]] forKey:ary[a]];
////        }
////
////    }
////    [userDefaults synchronize];
////}
//
//
//
//- (void)loginout{
//    
//    
////    NSArray *subs = [Subject MR_findByAttribute:@"name" withValue:[self getName] andOrderBy:@"disPlayOrder" ascending:YES];
//
//     NSArray *subs = [Adv MR_findAll];
//    if (subs.count >0) {
//        
//        for (Adv *sub in subs) {
//            
//            [sub MR_deleteEntity];
//            
//            [[sub managedObjectContext] MR_saveToPersistentStoreAndWait];
//            
//        }
//        
//        
//    }
//
//}
//
//- (void)getCodeWithPhoneNumber:(NSString *)phoneNumber type:(NSString *)type{
//    
//    NSDictionary *dic = @{@"phone":phoneNumber,@"type":type};
//    
//    [[HttpService sharedInstance]getCode:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//  
//                
//                if (_getCodeSuccess) {
//                    
//                    _getCodeSuccess(object);
//                }
//
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_getCodeFailure) {
//            
//            _getCodeFailure (responseString);
//        }
//        
//    }];
//    
//}
//
//- (void)getScoringWithUid:(NSString *)uid{
//    
//    NSDictionary *dic = @{@"uid":uid};
//    
//    [[HttpService sharedInstance]Scoring:dic completionBlock:^(id object) {
//        
//        if (object) {
//             
//            
//            
//          
//            
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//     
//        
//    }];
//}
//
//- (void)judgeCodeWithPhoneNumber:(NSString *)phoneNumber code:(NSString *)code{
//    
//    NSDictionary *dic = @{@"phone":phoneNumber,@"validCode":code};
//    
//    [[HttpService sharedInstance]judeCode:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//    
//                
//            if (_judgeCodeSuccess) {
//                    
//                    
//                _judgeCodeSuccess(object);
//             
//                
//            }
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_judgeCodeFailure){
//            
//            _judgeCodeFailure(responseString);
//        }
//        
//    }];
//    
//}
//
//
//- (void)registWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code{
//    
//    
//    NSDictionary *dic = @{@"phone":phoneNumber,@"password":passWord,@"code":code};
//    
//    [[HttpService sharedInstance]regist:dic completionBlock:^(id object) {
//        
//        if (object) {
//         
////            NSDictionary *dic = (NSDictionary *)object;
////            
////            UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
////            [self saveUserModelWithDictionary:dic];
////            if (model) {
//            
//                if (_registSuccess) {
//                    
//                    _registSuccess(object);
//                }
////
////            }
//
//        }
//                                              
//      } failureBlock:^(NSError *error, NSString *responseString) {
//          
//          if (_registFailure) {
//              
//              _registFailure (responseString);
//          }
//                                              
//       }];
//
//}
//
//
//- (void)loginWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord{
//    
//    NSDictionary *dic = @{@"phone":phoneNumber,@"password":passWord};
//    
//    [[HttpService sharedInstance]login:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//
//            
//            NSDictionary *dic = (NSDictionary *)object;
//            
//            PersonModel *model = [[PersonModel alloc]initWithDictionary:dic error:nil];
//            
//            
//            
//            if (model) {
//                
//                [self saveUserModelWithModel:model];
//                
//                if (_loginSuccess) {
//                    
//                    _loginSuccess(model);
//                }
//                
//            }
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_loginFailure) {
//            
//            _loginFailure (responseString);
//        }
//        
//    }];
//
//    
//}
//
//- (void)changePwWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord code:(NSString *)code{
//    
//    
//    NSDictionary *dic = @{@"phone":phoneNumber,@"password":passWord,@"code":code};
//    
//    [[HttpService sharedInstance]changePassWord:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
////            NSDictionary *dic = (NSDictionary *)object;
//            
////            UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
//            
////            [self saveUserModelWithDictionary:dic];
////            
////            if (model) {
//            
//                if (_changePWSuccess) {
//                    
//                    _changePWSuccess(object);
//                }
////                
////            }
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_changePWFailure) {
//            
//            _changePWFailure (responseString);
//        }
//        
//    }];
//
//}
//
//- (void)getAdvertisementWithType:(NSString *)type{
//    
//    
//    [[HttpService sharedInstance]getAd:nil completionBlock:^(id object) {
//        
//        if (object) {
//            
//
//            if (_getAdvertisementSuccess) {
//                
//                _getAdvertisementSuccess (object);
//            }
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_getAdvertisementFailure) {
//            
//            _getAdvertisementFailure(responseString);
//        }
//        
//    }];
//    
//    
//}
//
//- (void)getLuanchAdvertisement{
//    
//    [[HttpService sharedInstance]getLanuchAd:nil completionBlock:^(id object) {
//        
//        if (object) {
//            
//            NSMutableArray *ary = object[@"ad"];
//            
//            NSMutableArray *dataArray = [NSMutableArray array];
//            
//            for (NSDictionary *dic in ary) {
//                
//                LuanchAdvertisementModel *model = [[LuanchAdvertisementModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    [dataArray addObject:model];
//                }
//            }
//            
//            if (_getLanuchAdvertiseSuccess) {
//                
//                _getLanuchAdvertiseSuccess (dataArray);
//            }
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_getLanuchAdvertiseFailure) {
//            
//            _getLanuchAdvertiseFailure(responseString);
//        }
//        
//    }];
//
//}
//
//- (void)getUserDetailWithID:(NSString *)userId{
//    
//    NSDictionary *dic = @{@"token":userId};
//    
//    [[HttpService sharedInstance]getUserDetail:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//            NSDictionary *dic = object;
//            
//            PersonModel *model = [[PersonModel alloc]initWithDictionary:dic error:nil];
//            
//            
//            if (model) {
//                
//                [[LoginService shareInstanced]saveUserModelWithModel:model];
//                
//                if (_getUserDetailSuccess) {
//                    
//                    _getUserDetailSuccess(model);
//                }
//                
//            }
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_getUserDetailFailure) {
//            
//            _getUserDetailFailure(responseString);
//        }
//        
//    }];
//
//}
//
//- (void)upDateUserWithDictionary:(NSDictionary *)dic{
//    
//    
//    [[HttpService sharedInstance]updUserDetail:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//            if (_upDateUserDetailSuccess) {
//                
//                _upDateUserDetailSuccess(object);
//            }
//
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_upDateUserDetailFailure) {
//            
//            _upDateUserDetailFailure(responseString);
//        }
//        
//    }];
//
//}
//
//- (void)saveAvatarWithUserId:(NSString *)uid avatarString:(NSString *)avatarString{
//    //ad(广告) user(用户) aders(广告商)
//    
//    NSDictionary *dic = @{@"savePath":uid,@"imgStr":avatarString};
//    
//    [[HttpService sharedInstance]updUserAvatar:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//            if (_upDateAvatarSuccess) {
//                
//                _upDateAvatarSuccess(object);
//            }
//            
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_upDateAvatarFailure) {
//            
//            _upDateAvatarFailure(responseString);
//        }
//        
//    }];
//    
//    
//    
//}

@end
