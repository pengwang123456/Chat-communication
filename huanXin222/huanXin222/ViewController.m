//
//  ViewController.m
//  huanXin222
//
//  Created by wecar on 2017/5/5.
//  Copyright © 2017年 huanXin. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "LoginSuccessViewController.h"
#import <HyphenateLite/HyphenateLite.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWd;

//@property (nonatomic,strong) UITextField *userName;
//@property (nonatomic,strong) UITextField *passWd;
//@property (nonatomic,strong) UIButton *regisBtn;
//@property (nonatomic,strong) UIButton *loginBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    //self.view.backgroundColor = [UIColor whiteColor];
//    _userName = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
//    _passWd = [[UITextField alloc] initWithFrame:CGRectMake(100, 170, 200, 50)];
//    _regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _regisBtn.frame = CGRectMake(100, 200, 50, 30);
//    [_regisBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [_regisBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _loginBtn.frame = CGRectMake(200, 200, 50, 30);
//    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_loginBtn];
//    [self.view addSubview:_regisBtn];
//    [self.view addSubview:_userName];
//    [self.view addSubview:_passWd];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)registerClick:(id)sender {
    RegisterViewController *regi = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:regi animated:YES];

}

- (IBAction)loginClick:(id)sender {
    EMError *error = [[EMClient sharedClient] loginWithUsername:_userName.text password:_passWd.text];
    if (!error) {
        [self alertView:@"登录成功"];
        NSLog(@"登录成功");
        LoginSuccessViewController *login = [[LoginSuccessViewController alloc] initWithNibName:@"LoginSuccessViewController" bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
    }
    else{
        
        UIAlertView *lert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.errorDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [lert show];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
