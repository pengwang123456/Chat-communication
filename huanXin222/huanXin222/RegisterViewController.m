//
//  RegisterViewController.m
//  huanXin222
//
//  Created by wecar on 2017/5/5.
//  Copyright © 2017年 huanXin. All rights reserved.
//

#import "RegisterViewController.h"
#import <HyphenateLite/HyphenateLite.h>
#import "FriendViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWd;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)registerClick:(id)sender {
    //注册请求
    EMError *error = [[EMClient sharedClient] registerWithUsername:_userName.text password:_passWd.text];
    
    if (error==nil) {
//        成功
        [self alertView:@"注册成功"];

        NSLog(@"注册成功");
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
//        失败
        UIAlertView *lert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.errorDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [lert show];
        NSLog(@"%@",error.errorDescription);
    }

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
