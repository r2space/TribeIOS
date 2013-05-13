//
//  DAMemberDetailViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMemberDetailViewController.h"

@interface DAMemberDetailViewController ()
{
    DAUser *theUser;
    NSArray *theMessageList;
    BOOL isFollowed;
}

@end

@implementation DAMemberDetailViewController

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
    
    [[DAUserFetcher alloc] getUserById:self uid:self.uid];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    
    NSData *userdata = [[NSData alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", documentDir, [DALoginModule getLoginUserId]]];
    DAUser* loginuser = [NSKeyedUnarchiver unarchiveObjectWithData:userdata];
    
    isFollowed = [loginuser.following containsObject:self.uid];
    self.barFollow.title = isFollowed ? @"取消关注" : @"关注";
    [userdata writeToFile:[NSString stringWithFormat:@"%@/%@", documentDir, userdata] atomically:YES];

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
    return 1 + theMessageList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row);
    if (indexPath.row == 0) {
        DAMemberDetailCell *cell = [DAMemberDetailCell initWithMessage:theUser tableView:tableView];
        
        cell.lblName.text = theUser.name.name_zh;
        
//        NSLog(@"%@", theGroup.description);
//        cell.lblName.text = theGroup.name.name_zh;
//        cell.txtDescription.text = theGroup.description;
//        cell.imgPortrait.image = [theGroup getGroupPhotoImage];
//        cell.imgGroup.hidden = false;
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


- (void)didFinishFetchingUser:(DAUser *)user
{
    theUser = user;
    [[DAMessageModule alloc] getMessagesByUser:self.uid start:0 count:20 before:@"" callback:^(NSError *error, DAMessageList *messageList){
        theMessageList = messageList.items;
        [self.tblMessage reloadData];
    }];
}

- (IBAction)onCancelTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnHomeTouched:(id)sender {
    UITabBarController *controller = self.tabBarController;
    controller.selectedViewController = [controller.viewControllers objectAtIndex: 0];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (1 == item.tag) {
        // 关注的人
        DAMemberController *members = [[DAMemberController alloc] initWithNibName:@"DAMemberController" bundle:nil];
        members.uid = theUser._id;
        members.kind = DAMemberListFollowing;
        
        members.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:members animated:YES];
        [self presentViewController:members animated:YES completion:nil];
    }
    
    if (2 == item.tag) {
        // 粉丝
        DAMemberController *members = [[DAMemberController alloc] initWithNibName:@"DAMemberController" bundle:nil];
        members.uid = theUser._id;
        members.kind = DAMemberListFollower;
        
        members.hidesBottomBarWhenPushed = YES;
        //[self.navigationController pushViewController:members animated:YES];
        [self presentViewController:members animated:YES completion:nil];
    }
    
    if (3 == item.tag) {
        // 参加的组
        if (isFollowed) {
            [[DAUserFollowPoster alloc] follow:theUser._id delegateObj:self];
        } else {
            [[DAUserFollowPoster alloc] unfollow:theUser._id delegateObj:self];
        }
    }
    
    if (4 == item.tag) {
        // 关注/取消关注
        
        
    }
    
    if (5 == item.tag) {
        // 更多
        DAMemberMoreContainerViewController *moreViewController = [[DAMemberMoreContainerViewController alloc] initWithNibName:@"DAMemberMoreContainerViewController" bundle:nil];
        
        moreViewController.uid = theUser._id;
        [self.navigationController pushViewController:moreViewController animated:YES];
    }
}

- (void)didFinishFollow
{
    isFollowed = !isFollowed;
    self.barFollow.title = isFollowed ? @"取消关注" : @"关注";

    NSLog(@"finish follow");
}


@end
