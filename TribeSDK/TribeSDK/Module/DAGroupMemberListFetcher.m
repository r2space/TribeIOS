//
//  DAGroupMemberListFetcher.m
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAGroupMemberListFetcher.h"
#import "DAJsonAPIUrl.h"

@implementation DAGroupMemberListFetcher

+(void)getUserListInGroup:(NSString *)gid start:(int)start count:(int)count withDelegate:(id)delegateObj
{
    DAGroupMemberListFetcher *fetcher = [[DAGroupMemberListFetcher alloc] init];
    fetcher.delegate = delegateObj;
    [fetcher sendRequest:[DAJsonAPIUrl urlWithGetUserListInGroup:gid start:start count:count]];
}

-(void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *usersDict = [DAJsonHelper objectAtPath:jsonDict path:jsonPathUserList];
    DAUserList *users = [[DAUserList alloc] initWithDictionary:usersDict];
    
    [self.delegate didFinishFetchingGroupMemberList:users];
    self.delegate = nil;
}

@end

