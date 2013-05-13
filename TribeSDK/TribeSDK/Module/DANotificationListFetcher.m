//
//  DANotificationListFetcher.m
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DANotificationListFetcher.h"

@implementation DANotificationListFetcher

-(void) didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *dict = [DAJsonHelper objectAtPath:jsonDict path:@"data"];
    
    DANotificationList *notificationList = [[DANotificationList alloc] initWithDictionary:dict];
    
    if (self.delegate != nil) {
        [self.delegate didFinishFetchingNotificationList:notificationList];
    }
}

-(void)getNotificationList:(int)start count:(int)count type:(NSString *)type withDelegate:(id)delegateObj
{
    self.delegate = delegateObj;
    [self sendRequest:[DAJsonAPIUrl urlWithGetNotificationList:start count:count type:type]];
}

@end
