//
//  DAShortmailStoryViewCell.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/29.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAShortmailStoryViewCell : UITableViewCell

+(DAShortmailStoryViewCell *)initWithMessage:(DAShortmail *)shortmail tableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblUser;
@property (weak, nonatomic) IBOutlet UILabel *lblAt;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end
