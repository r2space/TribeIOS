//
//  DAFileDetailViewController.h
//  TribeIPhone
//
//  Created by mac on 13-5-6.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAFileDetailViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIImageView *imgFileType;
@property (weak, nonatomic) IBOutlet UILabel *lblFileName;
@property (weak, nonatomic) IBOutlet UILabel *lblAt;

@property (weak, nonatomic) IBOutlet UILabel *lblSize;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) DAFile *getfile;
@property (retain, nonatomic) DAFileList *fileList;

@property(nonatomic,retain) IBOutlet UIView *iview;

- (IBAction)onCancelTouched:(id)sender;
@end
