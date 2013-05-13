//
//  DAGroupController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAGroup.h>
#import <TribeSDK/DAGroupListFetcher.h>

@interface DAGroupController : UIViewController <DAGroupListFetcherDelegate>

@property (weak, nonatomic) NSString *uid;
- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblGroupList;

@end
