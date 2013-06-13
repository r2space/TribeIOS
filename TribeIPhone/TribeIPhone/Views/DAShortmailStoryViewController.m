//
//  DAShortmailStoryViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAShortmailStoryViewController.h"
#import "DAShortmailStoryViewCell.h"
#import "DAMemberController.h"

@interface DAShortmailStoryViewController ()
{
    NSArray *theMails;
    SocketIO *socket;
}

@end

@implementation DAShortmailStoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 没有用户ID，即新建会话
    if (self.uid == nil) {
        DAMemberController *members = [[DAMemberController alloc] initWithNibName:@"DAMemberController" bundle:nil];
        members.kind = DAMemberListAll;
        
        members.hidesBottomBarWhenPushed = YES;
        members.selectedBlocks = ^(DAUser *user){
            
            // 取消用户选择，则退回
            if (user == nil) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            self.uid = user._id;
            self.barUser.title = user.name.name_zh;
        };
        
        [self presentViewController:members animated:YES completion:nil];
    } else {
        [[DAShortmailModule alloc] getStoryByUser:self.uid start:0 count:20 callback:^(NSError *error, DAShortmailList *shortmails){
            theMails = shortmails.items;
            [self.tblStory reloadData];
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    NSLog(@"DAShortmailStoryViewController viewDidAppear");
    
    // 连接WebSocket
    if (socket || ![socket isConnected]) {
        socket = [[SocketIO alloc] initWithDelegate:self];
        [socket connectToHost:@"10.2.3.199" onPort:3001];

        // 发送用户ID
        NSMutableDictionary *userinfo = [NSMutableDictionary dictionary];
        [userinfo setObject:[DALoginModule getLoginUserId] forKey:@"id"];
        [socket sendEvent:@"userid" withData:userinfo];
    }
}

// 切断WebSocket连接
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"DAShortmailStoryViewController viewWillDisappear");
    [socket disconnect];
}

// 显示键盘的时候，调整View的位置
-(void)keyboardWillShow:(NSNotification*)note
{
    // get keyboard rect
    CGRect keyboardRect = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect bounds = [self.viewContainer bounds];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.viewContainer.frame = CGRectMake(0, - keyboardRect.size.height + 44, bounds.size.width, bounds.size.height);
                     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onCancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSendTouched:(id)sender
{
    DAShortmail *shortmail = [[DAShortmail alloc] init];
    shortmail.message = self.txtContent.text;
    shortmail._id = self.uid;

    [[DAShortmailModule alloc] send:shortmail callback:^(NSError *error, DAShortmail *shortmail) {
        NSLog(@"create ok!");
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return theMails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAShortmail *shortmail = [theMails objectAtIndex:indexPath.row];
	DAShortmailStoryViewCell *cell = [DAShortmailStoryViewCell initWithMessage:shortmail  tableView:tableView];
    
    cell.lblUser.text = shortmail.createby;
    cell.lblAt.text = shortmail.createat;
    cell.lblContent.text = shortmail.message;
    
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 91;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)onTextExit:(id)sender
{
    CGRect bounds = [self.viewContainer bounds];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.viewContainer.frame = CGRectMake(0, 44, bounds.size.width, bounds.size.height);
                     }];
    
    UITextField *textField = sender;
    [textField resignFirstResponder];
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSDictionary *data = [packet dataAsJSON];
    NSLog(@"didReceiveMessage() >>> data: %@", [data objectForKey:@"args"]);
}

- (void) socketIO:(SocketIO *)socket failedToConnectWithError:(NSError *)error
{
    NSLog(@"failedToConnectWithError() %@", error);
}


@end
