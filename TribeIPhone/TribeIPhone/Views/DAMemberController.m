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
    NSString *loginuid ;
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
    loginuid = [DALoginModule getLoginUserId];
    if (self.kind == DAMemberListAll) {
        self.barTitle.title = @"选择用户";
        [[DAUserModule alloc] getUserListStart:0 count:20 keywords:@"" callback:^(NSError *error, DAUserList *users){
            theMembers = users.items;
            [self.tblUsers reloadData];
        }];

    }
    if (self.kind == DAMemberListFollower) {
        self.barTitle.title = @"关注的人";
        
        [[DAUserModule alloc] getUserFollowerListByUser:self.uid start:0 count:20 keywords:@"" callback:^(NSError *error, DAUserList *users){
            theMembers = users.items;
            [self.tblUsers reloadData];
        }];
    }
    if (self.kind == DAMemberListFollowing) {
        self.barTitle.title = @"粉丝";

        [[DAUserModule alloc] getUserFollowingListByUser:self.uid start:0 count:20 keywords:@"" callback:^(NSError *error, DAUserList *users){
            theMembers = users.items;
            [self.tblUsers reloadData];
        }];
    }
    if (self.kind == DAMemberListGroupMember) {
        self.barTitle.title = @"成员";
        [[DAGroupModule alloc] getUserListInGroup:self.gid start:0 count:20 callback:^(NSError *error, DAUserList *users){
            theMembers = users.items;
            [self.tblUsers reloadData];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self dismissViewControllerAnimated:YES completion:^(void){
        if (self.selectedBlocks != nil) {
            self.selectedBlocks([theMembers objectAtIndex:indexPath.row]);
        }
    }];
}


- (IBAction)onCancelTouched:(id)sender {
    
//    [self.navigationController popViewControllerAnimated:YES];
    if (self.selectedBlocks != nil) {
        self.selectedBlocks(nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
