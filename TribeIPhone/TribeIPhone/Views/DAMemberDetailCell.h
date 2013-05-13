//
//  DAMemberDetailCell.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/18.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUser.h>
#import <TribeSDK/DAPictureFetcher.h>

@interface DAMemberDetailCell : UITableViewCell <DAPictureFetcherDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

+(DAMemberDetailCell *)initWithMessage:(DAUser *)group tableView:(UITableView *)tableView;

@end
