//
//  DAMemberFilterViewController.h
//  TribeIPhone
//
//  Created by Antony on 13-6-14.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
typedef void (^FilterDidSelected)(NSString *,NSString *,NSString *);


@interface DAMemberFilterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic)FilterDidSelected selectedBlocks;


-(IBAction)setSegment:(id)sender;
@end
