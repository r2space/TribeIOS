//
//  DAGroupDetailCell.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAGroup.h>
#import <TribeSDK/DAPictureFetcher.h>

@interface DAGroupDetailCell : UITableViewCell <DAPictureFetcherDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgGroup;
@property (weak, nonatomic) IBOutlet UIImageView *imgLock;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;

+(DAGroupDetailCell *)initWithMessage:(DAGroup *)group tableView:(UITableView *)tableView;

@end
