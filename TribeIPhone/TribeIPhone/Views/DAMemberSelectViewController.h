//
//  DAMemberSelectViewController.h
//  TribeIPhone
//
//  Created by kita on 13-4-25.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUserListFetcher.h>
#import "DAMemberCell.h"

@protocol DAMemberSelectViewControllerDelegate
-(void) didFinshSelectUser;
@end

@interface DAMemberSelectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, DAUserListFetcherDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSMutableArray *selectedUsers;
@property (nonatomic) BOOL allowMultiSelect;
@property (retain,nonatomic) id<DAMemberSelectViewControllerDelegate>delegate;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onSelectClicked:(id)sender;
@end
