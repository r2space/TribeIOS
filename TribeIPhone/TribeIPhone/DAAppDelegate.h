//
//  DAAppDelegate.h
//  TribeIPhone
//
//  Created by kita on 13-4-15.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAUserFetcher.h>
#import <TribeSDK/DALoginModule.h>

@interface DAAppDelegate : UIResponder <UIApplicationDelegate, DAUserFetcherrDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
