//
//  DAGroupSelectViewController.h
//  TribeIPhone
//
//  Created by kita on 13-4-24.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DAGroupCell.h"

@protocol DAGroupSelectViewControllerDelegate
-(void) didFinshSelectGroup;
@end

@interface DAGroupSelectViewController : UIViewController<DAGroupListFetcherDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSelect;
@property (weak, nonatomic) NSMutableArray *selectedGroups;
@property (nonatomic) BOOL allowMultiSelect;
@property (retain,nonatomic) id<DAGroupSelectViewControllerDelegate>delegate;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onSelectClicked:(id)sender;
@end
