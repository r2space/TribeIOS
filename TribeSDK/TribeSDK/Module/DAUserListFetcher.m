//
//  DAUserListFetcher.m
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAUserListFetcher.h"
#import "DAJsonAPIUrl.h"

@implementation DAUserListFetcher

+(void)getUserListStart:(int)start count:(int)count withDelegate:(id)delegateObj
{
    DAUserListFetcher *fetcher = [[DAUserListFetcher alloc] init];
    fetcher.delegate = delegateObj;
    [fetcher sendRequest:[DAJsonAPIUrl urlWithGetUserListStart:start count:count]];
}

-(void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *usersDict = [DAJsonHelper objectAtPath:jsonDict path:jsonPathUserList];
    DAUserList *users = [[DAUserList alloc] initWithDictionary:usersDict];
    
    [self.delegate didFinishFetchingUserList:users];
    self.delegate = nil;
}

@end
