//
//  DAGroupDetailViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAGroupDetailViewController.h"
#import "DAMemberController.h"
#import "DAGroupMoreContainerViewController.h"

@interface DAGroupDetailViewController ()
{
    DAGroup *theGroup;
    NSArray *theMessageList;
    BOOL isMember;
}

@end

@implementation DAGroupDetailViewController

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
    // Do any additional setup after loading the view from its nib.
    
//    [self.tblMessage setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[DAGroupModule alloc] getGroup:self.gid callback:^(NSError *error, DAGroup *group){
        theGroup = group;
    
        // 判断当前用户是否是组的成员
        for (NSString *member in group.member) {
            if ([member isEqualToString:[DALoginModule getLoginUserId]]) {
                isMember = YES;
                break;
            }
        }
        
        self.barJoinOrLeave.title = isMember ? @"退出" : @"加入";
        
        [[DAMessageModule alloc] getMessagesInGroup:group._id start:0 count:20 before:@"" callback:^(NSError *error, DAMessageList *messageList){
            theMessageList = messageList.items;
            [self.tblMessage reloadData];
        }];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + theMessageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row);
    if (indexPath.row == 0) {
        DAGroupDetailCell *cell = [DAGroupDetailCell initWithMessage:theGroup tableView:tableView];

        NSLog(@"%@", theGroup.description);
        cell.lblName.text = theGroup.name.name_zh;
        cell.txtDescription.text = theGroup.description;
        cell.imgPortrait.image = [theGroup getGroupPhotoImage];
        
        if ([@"1" isEqualToString:theGroup.type]) {
            if ([@"1" isEqualToString:theGroup.secure]) {
                cell.imgGroup.image = [UIImage imageNamed:@"group_security.png"];
            } else {
                cell.imgGroup.image = [UIImage imageNamed:@"group.png"];
            }
        } else {
            cell.imgGroup.image = [UIImage imageNamed:@"department.png"];
        }
        
        return cell;
    } else {
        DAMessageCell *cell = [DAMessageCell initWithMessage:[theMessageList objectAtIndex:indexPath.row - 1] tableView:tableView];
//        cell.parentController = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 232;
    }

    return [DAMessageCell cellHeightWithMessage:[theMessageList objectAtIndex:indexPath.row - 1]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (1 == item.tag) {
        // 成员
        DAMemberController *members = [[DAMemberController alloc] initWithNibName:@"DAMemberController" bundle:nil];
        members.gid = theGroup._id;
        members.kind = DAMemberListGroupMember;
        
        members.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:members animated:YES];
        [self presentViewController:members animated:YES completion:nil];
    }

    if (2 == item.tag) {
        // 添加
        DAMemberController *members = [[DAMemberController alloc] initWithNibName:@"DAMemberController" bundle:nil];
        members.kind = DAMemberListAll;
        members.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:members animated:YES];
        [self presentViewController:members animated:YES completion:nil];
    }

    if (3 == item.tag) {
        
        // 加入/退出
        if (isMember) {
            [[DAGroupModule alloc] leaveGroup:theGroup._id uid:[DALoginModule getLoginUserId] callback:^(NSError *error, DAGroup *group) {
                [self didFinishJoin:group];
            }];
        } else {
            [[DAGroupModule alloc] joinGroup:theGroup._id uid:[DALoginModule getLoginUserId] callback:^(NSError *error, DAGroup *group) {
                [self didFinishJoin:group];
            }];
        }
    }

    if (4 == item.tag) {
        // 更多
        DAGroupMoreContainerViewController *moreViewController = [[DAGroupMoreContainerViewController alloc] initWithNibName:@"DAGroupMoreContainerViewController" bundle:nil];
        
        moreViewController.group = theGroup;
        [self.navigationController pushViewController:moreViewController animated:YES];
    }

}

- (void)didFinishJoin:(DAGroup *)group
{
    NSLog(@"level success");
    isMember = !isMember;
    self.barJoinOrLeave.title = isMember ? @"退出" : @"加入";
}

- (IBAction)btnHomeTouched:(id)sender {
    UITabBarController *controller = self.tabBarController;
    controller.selectedViewController = [controller.viewControllers objectAtIndex: 0];
}
@end
