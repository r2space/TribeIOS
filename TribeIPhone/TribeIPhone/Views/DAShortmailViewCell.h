//
//  DAShortmailViewCell.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUser.h>
#import <TribeSDK/DAPictureFetcher.h>
#import <TribeSDK/DAPictureFetcher.h>


@interface DAShortmailViewCell : UITableViewCell <DAPictureFetcherDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblAt;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;

+(DAShortmailViewCell *)initWithMessage:(DAUser *)user tableView:(UITableView *)tableView;

@end
