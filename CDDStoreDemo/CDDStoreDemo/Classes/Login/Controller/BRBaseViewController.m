//
//  BRBaseViewController.m
//  HaoLive
//
//  Created by Mac on 16/5/24.
//  Copyright © 2016年 bairuitech. All rights reserved.
//

#import "BRBaseViewController.h"

@interface BRBaseViewController ()

@end

@implementation BRBaseViewController

-(BOOL)shouldAutorotate {
    return NO;
}
//只支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
