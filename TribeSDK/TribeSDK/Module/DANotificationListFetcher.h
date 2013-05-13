//
//  DANotificationListFetcher.h
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAWebAccess.h"
#import "DANotificationList.h"
#import "DAJsonAPIUrl.h"

@protocol DANotificationListDelegate

-(void)didFinishFetchingNotificationList:(DANotificationList *) notificationList;

@end


@interface DANotificationListFetcher : DAWebAccess

@property (strong, nonatomic) id<DANotificationListDelegate> delegate;
-(void)getNotificationList:(int)start count:(int)count type:(NSString *)type withDelegate:(id)delegateObj;

@end
