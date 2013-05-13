//
//  DAFileViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/24.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAFileModule.h>
#import <TribeSDK/DAFile.h>
#import <TribeSDK/DAFileList.h>
#import "DAFileDetailViewController.h"

@interface DAFileViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)onCancelTouched:(id)sender;
- (IBAction)onAddTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblFiles;

@end
