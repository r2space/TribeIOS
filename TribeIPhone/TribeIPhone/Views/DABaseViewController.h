//
//  DABaseViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/05/17.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "DAHelper.h"

@interface DABaseViewController : UIViewController
{
    UIRefreshControl    *refresh;
    MBProgressHUD       *progress;
}

@property (weak, nonatomic) UITableView *tableView;

- (void)refresh;
- (BOOL)startFetch;
- (BOOL)finishFetch:(NSError *)error;

@end
