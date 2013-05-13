//
//  DAMemberController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/19.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMemberController.h"

@interface DAMemberController ()
{
    NSArray *theMembers;
}

@end

@implementation DAMemberController

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
        
    if (self.kind == DAMemberListAll) {
        self.barTitle.title = @"所有用户";
        [DAUserListFetcher getUserListStart:0 count:20 withDelegate:self];
    }
    if (self.kind == DAMemberListFollower) {
        self.barTitle.title = @"关注的人";
        [DAUserFollowerFetcher getUserFollowerListByUser:self.uid start:0 count:20 withDelegate:self];
    }
    if (self.kind == DAMemberListFollowing) {
        self.barTitle.title = @"粉丝";
        [DAUserFollowingFetcher getUserFollowingListByUser:self.uid start:0 count:20 withDelegate:self];
    }
    if (self.kind == DAMemberListGroupMember) {
        self.barTitle.title = @"成员";
        [DAGroupMemberListFetcher getUserListInGroup:self.gid start:0 count:20 withDelegate:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didFinishFetchingUserList:(DAUserList *)userList
{
    theMembers = userList.items;
    [self.tblUsers reloadData];
}

- (void)didFinishFetchingGroupMemberList:(DAUserList *)userList
{
    theMembers = userList.items;
    [self.tblUsers reloadData];
}

- (void)didFinishFetchingUserFollowerList:(DAUserList *)userList
{
    theMembers = userList.items;
    [self.tblUsers reloadData];
}

- (void)didFinishFetchingUserFollowingList:(DAUserList *)userList
{
    theMembers = userList.items;
    [self.tblUsers reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return theMembers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAUser *user = [theMembers objectAtIndex:indexPath.row];
	DAMemberCell *cell = [DAMemberCell initWithMessage:user tableView:tableView];
    
    [cell lblName].text = [user getUserName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedBlocks != nil) {
        self.selectedBlocks([theMembers objectAtIndex:indexPath.row]);
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onCancelTouched:(id)sender {
    
//    [self.navigationController popViewControllerAnimated:YES];
    if (self.selectedBlocks != nil) {
        self.selectedBlocks(nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
