//
//  DAMemberMoreContainerViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUserUpdatePoster.h>
#import <TribeSDK/DAFilePoster.h>

@interface DAMemberMoreContainerViewController : UIViewController <DAFilePosterDelegate, DAUserUpdatePosterDelegate>
- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) NSString *uid;
- (IBAction)onSaveTouched:(id)sender;

@end
