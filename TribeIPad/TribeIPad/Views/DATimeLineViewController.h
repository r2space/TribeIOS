//
//  DATimeLineViewController.h
//  tribe-ipad
//
//  Created by LI LIN on 2013/04/11.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DATimeLineCell.h"
#import "DAMessageViewController.h"
#import <TribeSDK/DAMessageListFetcher.h>

@interface DATimeLineViewController : UIViewController <DAMessageListFetcherDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblMessageList;

@end
