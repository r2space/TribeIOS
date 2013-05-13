//
//  DANotificationFetcher.h
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DANotification.h"
#import "DAWebAccess.h"

@protocol DANotificationDelegate

-(void) didFinishFetchingNotification:(DANotification * ) notification;

@end

@interface DANotificationFetcher : DAWebAccess

@property (strong, nonatomic) id<DANotificationDelegate> delegate;

@end
