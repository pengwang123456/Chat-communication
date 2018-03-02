//
//  ChatViewController.m
//  huanXin222
//
//  Created by wecar on 2017/5/8.
//  Copyright © 2017年 huanXin. All rights reserved.
//

#import "ChatViewController.h"
#import <HyphenateLite/HyphenateLite.h>
#import "TableViewCell.h"
#import "MBProgressHUD.h"
@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextField *chatContent;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) EMConversation *conver;
@end

@implementation ChatViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = [NSString stringWithFormat:@"与%@聊天中。。。",_name];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 200) style:UITableViewStylePlain];
    _arr = [[NSMutableArray alloc] init];
    _chatContent.delegate = self;
    _chatContent.placeholder = @"请输入聊天内容";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self.view addSubview:_tableView];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil]; //聊天代理
//获取与_name的聊天记录（包括双方的聊天对话内容）
    _conver = [[EMClient sharedClient].chatManager getConversation:_name type:EMConversationTypeChat createIfNotExist:YES];
    long timestamp = [[NSDate date] timeIntervalSince1970]*1000 + 1;
        [_conver loadMessagesWithType:EMMessageBodyTypeText timestamp:timestamp count:100 fromUser:nil searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
//            获取成功后添加到数据源
            for (EMMessage *age in aMessages) {
                NSMutableDictionary *dic = [NSMutableDictionary new];
                EMTextMessageBody *body = (EMTextMessageBody *)age.body;
                [dic setObject:body.text forKey:age.to];
                [_arr addObject:dic];
            }
            [_tableView reloadData];
            
            //刚进入聊天界面时，获取到聊天信息后直接定位到最新的消息行，最底部
            if (_arr.count > 0) {
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_arr.count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
            }
            
        }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _sendBtn.transform = CGAffineTransformMakeTranslation(0, -168);
    _chatContent.transform = CGAffineTransformMakeTranslation(0, -168);
    _tableView.transform = CGAffineTransformMakeTranslation(0, -168);
}

- (IBAction)sendClick:(id)sender {
    _sendBtn.transform = CGAffineTransformMakeTranslation(0, 0);
    _chatContent.transform = CGAffineTransformMakeTranslation(0, 0);
    _tableView.transform = CGAffineTransformMakeTranslation(0, 0);
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:_chatContent.text];
    NSString *name = [[EMClient sharedClient] currentUsername];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:_name from:name to:_name body:body ext:nil];
    message.chatType = EMChatTypeChat;
    //发送消息
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        NSLog(@"%d",progress);
    } completion:^(EMMessage *message, EMError *error) {
        
        _chatContent.text = @""; // 发送成功后清除输入框
        [self.view endEditing:YES];
//        成功后回调block中获取消息内容
         EMTextMessageBody *body = (EMTextMessageBody *)message.body;
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:body.text forKey:message.to];
//        添加到数据源中，刷新tableview
        [_arr addObject:dic];
        [_tableView reloadData];
        //发送消息成功后，要定位到刚发送的消息那一行上
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_arr.count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   [self.view endEditing:YES];
    _sendBtn.transform = CGAffineTransformMakeTranslation(0, 0);
    _chatContent.transform = CGAffineTransformMakeTranslation(0, 0);
    _tableView.transform = CGAffineTransformMakeTranslation(0, 0);
}


-(void)messagesDidReceive:(NSArray *)aMessages
{
    NSString *name = [[EMClient sharedClient] currentUsername];
    EMConversation *conver = [[EMClient sharedClient].chatManager getConversation:name type:EMConversationTypeChat createIfNotExist:YES];
    long timestamp = [[NSDate date] timeIntervalSince1970]*1000 + 1;
    [conver loadMessagesWithType:EMMessageBodyTypeText timestamp:timestamp count:100 fromUser:nil searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        for (EMMessage *age in aMessages) {
            EMTextMessageBody *body = (EMTextMessageBody *)age.body;
            [_arr addObject:body.text];
        }
        [_tableView reloadData];
    }];
    NSLog(@"接收消息：%@",aMessages);
}

-(void)messagesDidRead:(NSArray *)aMessages
{
    NSLog(@"已经读取消息：%@",aMessages);
}


//消息状态发生变化
- (void)messageStatusDidChange:(EMMessage *)aMessage
                         error:(EMError *)aError
{
    NSLog(@"消息状态发生变化");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic = _arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *username = [[EMClient sharedClient] currentUsername];
    if ([dic objectForKey:username] != nil) {
        for (UIView *vie in cell.contentView.subviews) {
            [vie removeFromSuperview];
        }
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 120, 60)];
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = (NSString *)[dic objectForKey:username];
        lab.textColor = [UIColor redColor];
        [cell.contentView addSubview:lab];
    }
    else
    {
        for (UIView *vie in cell.contentView.subviews) {
            [vie removeFromSuperview];
        }
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130, 5, 120, 60)];
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentRight;
        lab.textColor = [UIColor blueColor];
        lab.text = (NSString *)[dic objectForKey:_name];
        [cell.contentView addSubview:lab];
    }
    return cell;
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
