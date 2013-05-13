//
//  DAMemberCell.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/19.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUser.h>
#import <TribeSDK/DAPictureFetcher.h>

@interface DAMemberCell : UITableViewCell <DAPictureFetcherDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblGroup;

+(DAMemberCell *)initWithMessage:(DAUser *)user tableView:(UITableView *)tableView;

@end
