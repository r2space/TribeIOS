//
//  DANotificationList.h
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAHeader.h"
#import "DANotification.h"

@interface DANotificationList : Jastor

@property (retain, nonatomic) NSNumber *total;
@property (retain, nonatomic) NSArray *items;

@end
