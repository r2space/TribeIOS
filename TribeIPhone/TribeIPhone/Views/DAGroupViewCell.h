//
//  DAGroupViewCell.h
//  tribe
//
//  Created by 李 林 on 2012/12/13.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAFileModule.h>
#import <TribeSDK/DAGroup.h>

@interface DAGroupViewCell : UITableViewCell

+(DAGroupViewCell *)initWithMessage:(DAGroup *)group tableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblOwner;
@property (weak, nonatomic) NSString* gid;

@end
