//
//  BaseViewController.m
//  huanXin222
//
//  Created by wecar on 2018/2/28.
//  Copyright © 2018年 huanXin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)alertView:(NSString *)alertTitle{
    MBProgressHUD *mb = [[MBProgressHUD alloc] init];
    mb.mode = MBProgressHUDModeText;
    mb.labelText = @"登录成功";
    UIWindow *wind = [UIApplication sharedApplication].keyWindow;
    [wind addSubview:mb];
    [mb show:YES];
    [mb removeFromSuperViewOnHide];
    [mb hide:YES afterDelay:1.0];
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
