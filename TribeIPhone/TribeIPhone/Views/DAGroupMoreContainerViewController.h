//
//  DAGroupMoreContainerViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAGroupMoreContainerViewController : UIViewController

@property (weak, nonatomic) DAGroup *group;
- (IBAction)onCancelTouched:(id)sender;
- (IBAction)onSaveTouched:(id)sender;


@end
