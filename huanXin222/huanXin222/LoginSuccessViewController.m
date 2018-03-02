//
//  LoginSuccessViewController.m
//  huanXin222
//
//  Created by wecar on 2017/5/6.
//  Copyright © 2017年 huanXin. All rights reserved.
//

#import "LoginSuccessViewController.h"
#import "FriendViewController.h"
#import "AddFriendViewController.h"
#import <HyphenateLite/HyphenateLite.h>
@interface LoginSuccessViewController ()<EMContactManagerDelegate,UIAlertViewDelegate>

@property NSString *uName;

@end

@implementation LoginSuccessViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (IBAction)logout:(UIButton *)sender {
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        if (!aError) {
            NSLog(@"用户已退出");
            [self alertView:@"退出成功"];
//            UIAlertView *lert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退出成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [lert show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}
- (IBAction)friendList:(id)sender {
    FriendViewController *friend = [FriendViewController new];
    [self.navigationController pushViewController:friend animated:YES];
}
- (IBAction)addFriend:(id)sender {
    AddFriendViewController *add = [[AddFriendViewController alloc] initWithNibName:@"AddFriendViewController" bundle:nil];
    [self.navigationController pushViewController:add animated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//有添加好友申请回调
-(void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage
{
    _uName = aUsername;
    NSString *str = [[NSString alloc] initWithFormat:@"%@想添加你为好友",aUsername];
    UIAlertView *lert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"同意" otherButtonTitles:@"拒绝", nil];
    [lert show];
    
    

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 同意好友请求的方法
        EMError *agreeError = [[EMClient sharedClient].contactManager acceptInvitationForUsername:_uName];
        if (!agreeError) {
            NSLog(@"发送同意成功");
        }
    }
    else{
        EMError *refused = [[EMClient sharedClient].contactManager declineInvitationForUsername:_uName];
        if (!refused) {
            NSLog(@"发送拒绝成功");
            
        }
    }
    
}

//拒绝好友申请回调
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    NSLog(@"%@拒绝了我的好友请求",aUsername);
}

//同意好友申请回调
- (void)friendshipDidAddByUser:(NSString *)aUsername{
    NSLog(@"%@同意了我的好友请求",aUsername);
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
