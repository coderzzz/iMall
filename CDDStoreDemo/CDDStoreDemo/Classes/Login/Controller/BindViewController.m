//
//  BindViewController.m
//  CDDStoreDemo
//
//  Created by sam on 2017/9/9.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "BindViewController.h"
#import "AppDelegate.h"
#import "DCTabBarController.h"
@interface BindViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UIButton *wordBtn;

@end

@implementation BindViewController
{
    dispatch_source_t timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷绑定";
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    [self setUpWordBtn];
    
}

- (void)setUpWordBtn{
    
    self.wordBtn.layer.masksToBounds = YES;
    self.wordBtn.layer.cornerRadius = 4;
    self.wordBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.wordBtn.layer.borderWidth = 1;
    
}


- (IBAction)word:(id)sender {
    
    
    if (self.phoneTF.text.length<11) {
        
        [self showTipWithStr:@"请输入合法的手机号码"];
        return;
    }
    
    [BAIRUITECH_NetWorkManager FinanceLiveShow_SMSCodeParam:@{@"phone":self.phoneTF.text} withSuccessBlock:^(NSDictionary *object) {
        
        
        
        if([object[@"error"]intValue] == 0){
            
            self.wordBtn.userInteractionEnabled = NO;
            timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            __block int sec = 60;
            dispatch_source_set_event_handler(timer, ^{
                
                [self.wordBtn setTitle:[NSString stringWithFormat:@"重新获取（%d）",sec] forState:UIControlStateNormal];
                sec--;
                if (sec<=0) {
                    
                    dispatch_source_cancel(timer);
                    self.wordBtn.userInteractionEnabled = YES;
                }
            });
            dispatch_resume(timer);
            
            
            
        }else{
            
            
        }
        
        
    } withFailureBlock:^(NSError *error) {
        
        
        //        YJLog(@"error %@",error);
        
        
    }];
    
}

- (IBAction)bingd:(id)sender {
    
    if (self.phoneTF.text.length<11) {
        
        [self showTipWithStr:@"请输入合法的手机号码"];
        return;
    }
    if (self.passTF.text.length<3) {
        
        [self showTipWithStr:@"请输入合法的验证码"];
        return;
    }
    NSMutableDictionary *dic = @{@"phone":self.phoneTF.text,@"code":self.passTF.text}.mutableCopy;
    [dic addEntriesFromDictionary:self.wechatDic];
    [BAIRUITECH_NetWorkManager FinanceLiveShow_bing:dic withSuccessBlock:^(NSDictionary *object) {
        
        if([object[@"error"]intValue] == 0){

            DCUserInfo *userInfo = [DCUserInfo mj_objectWithKeyValues:object[@"data"]];;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{//异步保存
                [userInfo save];
            });
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            dele.window.rootViewController = [[DCTabBarController alloc] init];
            
            
        }else{
            
            
        }
        
        
    } withFailureBlock:^(NSError *error) {
        
        
        //        YJLog(@"error %@",error);
        
        
    }];
    
    
}


@end
