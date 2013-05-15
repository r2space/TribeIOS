//
//  DACreateMessageViewController.h
//  tribe
//
//  Created by 李 林 on 2012/12/04.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <TribeSDK/DAMessageModule.h>
#import <TribeSDK/DAFileModule.h>
#import <TribeSDK/DAFile.h>
#import "DAMemberSelectViewController.h"
#import "DAGroupSelectViewController.h"
#import "DAHelper.h"

@interface DAContributeViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, CLLocationManagerDelegate, DAMemberSelectViewControllerDelegate,DAGroupSelectViewControllerDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnClearImg;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UILabel *lblRange;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UIImageView *imgAttach;
@property (weak, nonatomic) IBOutlet UIView *optionView;

@property (retain, nonatomic) DAMessage *message;
@property (nonatomic) BOOL isForward;

- (IBAction)onLocationClicked:(id)sender;
- (IBAction)onCameraClicked:(id)sender;
- (IBAction)onAtClicked:(id)sender;
- (IBAction)onMoticonClicked:(id)sender;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onRangeClicked:(id)sender;
- (IBAction)onSendClicked:(id)sender;
- (IBAction)onClearImgClicked:(id)sender;
@end
