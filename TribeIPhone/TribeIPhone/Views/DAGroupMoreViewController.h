//
//  DAGroupMoreViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAGroup.h>

@interface DAGroupMoreViewController : UITableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) DAGroup *group;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtDescription;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segSecurity;
@property (weak, nonatomic) IBOutlet UIImageView *imgPortrait;

@end
