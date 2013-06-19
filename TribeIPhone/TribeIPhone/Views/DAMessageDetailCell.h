//
//  DAMessageDetailCell.h
//  TribeIPhone
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAMessage.h>
#import "DAMessageLabel.h"
#import "DAMessageAtView.h"
#import "DAMessageFileView.h"
#import "DAPictureScrollView.h"

@interface DAMessageDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCreateAt;
@property (weak, nonatomic) DAMessageLabel *lblMessage;
@property (weak, nonatomic) DAMessageAtView *atArea;
@property (weak, nonatomic) DAMessageFileView *fileArea;
//@property (weak, nonatomic) IBOutlet UIImageView *imgAttach;
@property (weak, nonatomic) IBOutlet DAPictureScrollView *scrollView;
@property(retain,nonatomic) NSArray *PictureIds;

+(DAMessageDetailCell *) initWithMessage:(DAMessage *)message tableView:(UITableView *)tableView;
+(float)cellHeightWithMessage:(DAMessage *)message;
-(float)cellHeight;
@end
