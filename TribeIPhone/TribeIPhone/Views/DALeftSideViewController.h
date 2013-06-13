//
//  DAMessageFilterViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/06/07.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DABaseViewController.h"


@interface DALeftSideViewController : UIViewController

@property (nonatomic, retain) NSArray *dataList;

@property (weak, nonatomic) IBOutlet UITableView *tblFilter;

@property (retain, nonatomic) UIViewController *contentController;




-(IBAction)setSegment:(id)sender;

@end
