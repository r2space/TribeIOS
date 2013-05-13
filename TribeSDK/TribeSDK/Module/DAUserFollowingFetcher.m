//
//  DAUserFollowingFetcher.m
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAUserFollowingFetcher.h"
#import "DAJsonAPIUrl.h"

@implementation DAUserFollowingFetcher
+(void)getUserFollowingListByUser:(NSString *)userId start:(int)start count:(int)count withDelegate:(id)delegateObj
{
    DAUserFollowingFetcher *fetcher = [[DAUserFollowingFetcher alloc] init];
    fetcher.delegate = delegateObj;
    [fetcher sendRequest:[DAJsonAPIUrl urlWithGetFollowingListByUser:userId start:start count:count]];
}

-(void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *usersDict = [DAJsonHelper objectAtPath:jsonDict path:jsonPathUserList];
    DAUserList *users = [[DAUserList alloc] initWithDictionary:usersDict];
    
    [self.delegate didFinishFetchingUserFollowingList:users];
    self.delegate = nil;
    
}
@end
