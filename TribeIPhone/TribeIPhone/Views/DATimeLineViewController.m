//
//  DAFirstViewController.m
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DATimeLineViewController.h"
#import "MBProgressHUD.h"

#define COUNT_PER_PAGE 20

@interface DATimeLineViewController ()
{
    NSArray* messages;
    BOOL _hasMore;
    BOOL _loadingMore;
    
    UIRefreshControl *_refreshControl;
    MBProgressHUD *_hud;
}
- (IBAction)timeLineViewActionForSegue:(UIStoryboardSegue *)segue;

@end

@implementation DATimeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加Pull To Refresh控件
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = DAColor;
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    
    // 初始化，并显示HUD
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];    
    [self showMessages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_hasMore) {
        return messages.count + 1;
    }
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_hasMore && indexPath.row == messages.count) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = @"More";
        return cell;
    }
    DAMessage *message = [messages objectAtIndex:indexPath.row];
	DAMessageCell *cell = [DAMessageCell initWithMessage:message tableView:tableView];
    cell.parentController = self;

    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (_hasMore && indexPath.row == messages.count) {
        return 50;
    }
    
    return [DAMessageCell cellHeightWithMessage:[messages objectAtIndex:indexPath.row]];
}

- (IBAction)timeLineViewActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"First view return action invoked.");
}

- (IBAction)onRefreshClicked:(id)sender
{
    [self showMessages];
}

- (IBAction)onContributeClicked:(id)sender
{
    DAContributeViewController *ctrl = [[DAContributeViewController alloc] initWithNibName:@"DAContributeViewController" bundle:nil];
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (void)showMessages
{
    [self getMessages:0 count:COUNT_PER_PAGE before:@""];
}

- (void)getMessages:(int)start count:(int)count before:(NSString *)date
{
    _hud.labelText = @"Loging...";
    _hud.color = DAColor;
    [_hud show:YES];
    [[DAMessageModule alloc] getMessagesInTimeLineStart:start count:count before:date callback:^(NSError *error, DAMessageList *messageList){
        _hasMore = COUNT_PER_PAGE <= messageList.items.count;
        if (!_loadingMore) {
            messages = messageList.items;
            [self.tableView reloadData];
            [self.tableView setContentOffset:CGPointMake(0,0) animated:YES]; // scroll to top
        } else{
            messages = [messages arrayByAddingObjectsFromArray:messageList.items];
            [self.tableView reloadData];
            _loadingMore = NO;
        }
        
        [_hud hide:YES];
        [_refreshControl endRefreshing];
    }];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hasMore && indexPath.row == messages.count) {
        DAMessage *lastMsg = [messages objectAtIndex:messages.count - 1];
        _loadingMore = YES;
        [self getMessages:0 count:COUNT_PER_PAGE before:lastMsg.createat];
        return;
    }
    
    DAMessageDetailViewController *detailViewController = [[DAMessageDetailViewController alloc] initWithNibName:@"DAMessageDetailViewController" bundle:nil];
    detailViewController.message = [messages objectAtIndex:indexPath.row];
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
     
}

- (void)refresh
{
    NSLog(@"refresh");
    
    [self showMessages];
}

@end
