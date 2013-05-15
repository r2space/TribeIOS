//
//  DAGroupModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/15.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupModule.h"

#define kURLGetGroupMember @"group/members.json?start=%d&count=%d&gid=%@"

@implementation DAGroupModule

- (void)getUserListInGroup:(NSString *)gid start:(int)start count:(int)count callback:(void (^)(NSError *error, DAUserList *users))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetGroupMember, start, count, gid];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUserList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
