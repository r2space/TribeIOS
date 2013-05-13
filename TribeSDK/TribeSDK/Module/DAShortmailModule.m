//
//  DASortmailCreatePoster.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAShortmailModule.h"

#define kURLCreate  @"shortmail/creat.json"
#define kURLStory   @"shortmail/story.json?uid=%@&type=earlier&start=%d&count=%d"
#define kURLUsers   @"shortmail/users.json?start=%d&count=%d"

@implementation DAShortmailModule

- (void)send:(DAShortmail *)shortmail callback:(void (^)(NSError *error, DAShortmail *shortmail))callback
{
    NSDictionary *params = [shortmail toDictionary];

    [[DAAFHttpClient sharedClient] postPath:kURLCreate parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAShortmail alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)getStoryByUser:(NSString *)uid
                 start:(int)start
                 count:(int)count
              callback:(void (^)(NSError *error, DAShortmailList *shortmails))callback
{
    NSString *path = [NSString stringWithFormat:kURLStory, uid, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAShortmailList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)getUsers:(int)start count:(int)count callback:(void (^)(NSError *error, DAUserList *users))callback
{
    NSString *path = [NSString stringWithFormat:kURLUsers, start, count];
    
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
