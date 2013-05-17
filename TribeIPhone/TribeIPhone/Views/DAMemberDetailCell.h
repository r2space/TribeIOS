//
//  DAMemberDetailCell.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/18.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAMemberDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

+(DAMemberDetailCell *)initWithMessage:(DAUser *)group tableView:(UITableView *)tableView;

@end
