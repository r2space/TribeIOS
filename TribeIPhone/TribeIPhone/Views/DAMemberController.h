//
//  DAMemberController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/19.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DAMemberCell.h"


typedef enum {
    DAMemberListGroupMember = 1,
    //2 粉丝
    DAMemberListFollower = 2,
    //3 关注的人 
    DAMemberListFollowing = 3,
    DAMemberListAll = 4
} DAMemberListType;

typedef void (^UserDidSelected)(DAUser *);

@interface DAMemberController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblUsers;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (nonatomic) DAMemberListType kind;
@property (weak, nonatomic) NSString *uid;
@property (weak, nonatomic) NSString *gid;
@property (strong, nonatomic) UserDidSelected selectedBlocks;

- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barTitle;

@end

