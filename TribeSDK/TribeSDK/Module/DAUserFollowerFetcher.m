//
//  DAUserFollowerFetcher.m
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAUserFollowerFetcher.h"
#import "DAJsonAPIUrl.h"

@implementation DAUserFollowerFetcher
+(void)getUserFollowerListByUser:(NSString *)userId start:(int)start count:(int)count withDelegate:(id)delegateObj
{
    DAUserFollowerFetcher *fetcher = [[DAUserFollowerFetcher alloc] init];
    fetcher.delegate = delegateObj;
    [fetcher sendRequest:[DAJsonAPIUrl urlWithGetFollowerListByUser:userId start:start count:count]];
}

-(void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *usersDict = [DAJsonHelper objectAtPath:jsonDict path:jsonPathUserList];
    DAUserList *users = [[DAUserList alloc] initWithDictionary:usersDict];
    
    [self.delegate didFinishFetchingUserFollowerList:users];
    self.delegate = nil;

}
@end
