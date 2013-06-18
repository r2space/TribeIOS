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

typedef void (^GroupsDidSelected)(NSArray *groups);

@interface DAGroupSelectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSelect;
@property (weak, nonatomic) NSMutableArray *selectedGroups;
@property (nonatomic) BOOL allowMultiSelect;
@property(strong, nonatomic) GroupsDidSelected selectedBlocks;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onSelectClicked:(id)sender;
@end
