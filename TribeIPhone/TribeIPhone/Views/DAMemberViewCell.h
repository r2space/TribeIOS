//
//  DAFriendViewCell.h
//  tribe
//
//  Created by 李 林 on 2012/12/15.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUser.h>
#import <TribeSDK/DAFileModule.h>

@interface DAMemberViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) NSString* uid;

+(DAMemberViewCell *)initWithMessage:(DAUser *)user tableView:(UITableView *)tableView;

@end
