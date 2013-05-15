//
//  DACommentCell.h
//  TribeIPhone
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAMessage.h>
#import <TribeSDK/DAFileModule.h>
#import "DAMessageLabel.h"

@interface DACommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblCreateBy;
@property (weak, nonatomic) UILabel *lblComment;

+(DACommentCell *)initWithComment:(DAMessage *)comment tableView:(UITableView *)tableView;
+(float)cellHeightWithComment:(DAMessage *)comment;

@end
