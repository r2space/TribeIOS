//
//  DAGroupViewController.h
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAGroupListFetcher.h>

@interface DAGroupViewController : UIViewController <DAGroupListFetcherDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onAddTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblGroups;

@end