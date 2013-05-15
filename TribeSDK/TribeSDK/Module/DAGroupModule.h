//
//  DAGroupModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/15.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAAFHttpClient.h"
#import "DAUserList.h"

@interface DAGroupModule : NSObject

- (void)getUserListInGroup:(NSString *)gid start:(int)start count:(int)count callback:(void (^)(NSError *error, DAUserList *users))callback;

@end
