//
//  DAGroupMoreContainerViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAGroupUpdatePoster.h>
#import <TribeSDK/DAFilePoster.h>
#import <TribeSDK/DAGroup.h>

@interface DAGroupMoreContainerViewController : UIViewController <DAGroupUpdatePosterDelegate, DAFilePosterDelegate>

@property (weak, nonatomic) DAGroup *group;
- (IBAction)onCancelTouched:(id)sender;
- (IBAction)onSaveTouched:(id)sender;


@end
