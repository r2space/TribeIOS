//
//  DAFileDetailViewController.h
//  TribeIPhone
//
//  Created by mac on 13-5-6.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAFile.h>
#import <TribeSDK/DAFileDetail.h>
#import <TribeSDK/DAFileHistory.h>
#import <TribeSDK/DAFileList.h>
#import <TribeSDK/DAFileModule.h>

@interface DAFileDetailViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIImageView *imgFileType;
@property (weak, nonatomic) IBOutlet UILabel *lblFileName;
@property (weak, nonatomic) IBOutlet UILabel *lblAt;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar    *tabbar;
@property (retain, nonatomic) DAFile *getfile;
@property (retain, nonatomic) DAFileList *fileList;


- (IBAction)onCancelTouched:(id)sender;
@end
