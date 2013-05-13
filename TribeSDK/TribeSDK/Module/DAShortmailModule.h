//
//  DASortmailCreatePoster.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAShortmail.h"
#import "DAShortmailList.h"
#import "DAUserList.h"

@interface DAShortmailModule : NSObject

// 发送私信
- (void)send:(DAShortmail *)shortmail
    callback:(void (^)(NSError *error, DAShortmail *shortmail))callback;

// 获取私信对话
- (void)getStoryByUser:(NSString *)uid
                 start:(int)start
                 count:(int)count
              callback:(void (^)(NSError *error, DAShortmailList *shortmails))callback;

// 获取私信用户一览
- (void)getUsers:(int)start
           count:(int)count
        callback:(void (^)(NSError *error, DAUserList *users))callback;

@end
