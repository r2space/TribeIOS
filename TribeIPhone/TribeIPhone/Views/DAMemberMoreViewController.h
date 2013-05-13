//
//  DAMemberMoreViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAMemberMoreViewController : UITableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)didEndOnExit:(id)sender;
@property (weak, nonatomic) NSString *uid;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segLang;

@end
