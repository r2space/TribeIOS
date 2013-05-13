//
//  DANotificationFetcher.m
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DANotificationFetcher.h"

@implementation DANotificationFetcher

-(void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *notificationDict = [DAJsonHelper objectAtPath:jsonDict path:@"data"];
    
    DANotification *notification = [[DANotification alloc] initWithDictionary:notificationDict];
    
    if (self.delegate != nil) {
        [self.delegate didFinishFetchingNotification:notification];
    }

}

@end
