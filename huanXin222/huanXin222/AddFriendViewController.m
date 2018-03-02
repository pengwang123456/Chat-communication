//
//  AddFriendViewController.m
//  huanXin222
//
//  Created by wecar on 2017/5/6.
//  Copyright © 2017年 huanXin. All rights reserved.
//

#import "AddFriendViewController.h"
#import <HyphenateLite/HyphenateLite.h>
@interface AddFriendViewController ()
@property (weak, nonatomic) IBOutlet UITextField *friendUser;

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加好友";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)addFriendClick:(id)sender {
    EMError *error = [[EMClient sharedClient].contactManager addContact:_friendUser.text message:@"我想加你为好友"];
    if (!error) {
        NSLog(@"添加成功");
        [self alertView:@"添加请求发送成功"];
//        UIAlertView *lert = [[UIAlertView alloc] initWithTitle:@"添加请求发送成功" message:error.errorDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [lert show];
        [self.navigationController popViewControllerAnimated:YES];
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
