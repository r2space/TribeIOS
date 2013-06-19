//
//  DAFileSelectViewController.h
//  TribeIPhone
//
//  Created by kita on 13-6-19.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

typedef void (^FilesDidSelected)(NSArray *files);

@interface DAFileSelectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSMutableArray *selectedFiles;
@property (nonatomic) BOOL allowMultiSelect;
@property(strong, nonatomic) FilesDidSelected selectedBlocks;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onSelectClicked:(id)sender;
@end
