//
//  DANotificationCell.h
//  TribeIPhone
//
//  Created by kita on 13-5-3.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DANotification.h>
#import <TribeSDK/DAPictureFetcher.h>

@interface DANotificationCell : UITableViewCell<DAPictureFetcherDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

+(DANotificationCell *) initWithNotification:(DANotification *)notification tableView:(UITableView *)tableView;
@end
