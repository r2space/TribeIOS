//
//  DAMemberController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/19.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUserListFetcher.h>
#import <TribeSDK/DAGroupMemberListFetcher.h>
#import <TribeSDK/DAUserFollowerFetcher.h>
#import <TribeSDK/DAUserFollowingFetcher.h>
#import <TribeSDK/DAUser.h>
#import <TribeSDK/DAUserList.h>
#import "DAMemberCell.h"


typedef enum {
    DAMemberListGroupMember = 1,
    DAMemberListFollower = 2,
    DAMemberListFollowing = 3,
    DAMemberListAll = 4
} DAMemberListType;

typedef void (^UserDidSelected)(DAUser *);

@interface DAMemberController : UIViewController<DAUserListFetcherDelegate, DAGroupMemberListFetcherDelegate, DAUserFollowerFetcherDelegate, DAUserFollowingFetcherDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblUsers;
@property (nonatomic) DAMemberListType kind;
@property (weak, nonatomic) NSString *uid;
@property (weak, nonatomic) NSString *gid;

@property (strong, nonatomic) UserDidSelected selectedBlocks;

- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barTitle;

@end
