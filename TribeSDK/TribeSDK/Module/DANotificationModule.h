//
//  DANotificationModule.h
//  TribeSDK
//
//  Created by kita on 13-5-3.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DANotificationList.h"

@interface DANotificationModule : NSObject

-(void) getNotificationListByType: (NSString *)type start:(int)start count:(int)count callback:(void (^)(NSError *error, DANotificationList *notificationList))callback;

@end
