//
//  DAFriendViewController.h
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAMemberViewController : UIViewController <DAUserListFetcherDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
