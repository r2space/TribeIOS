//
//  DAAtMeMessageListFetcher.m
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAAtMeMessageListFetcher.h"
#import "DAJsonAPIUrl.h"

@implementation DAAtMeMessageListFetcher
+(void)getAtMeMessagesStart:(int)start count:(int)count withDelegate:(id)delegateObj
{
    DAAtMeMessageListFetcher *fetcher = [[DAAtMeMessageListFetcher alloc] init];
    fetcher.delegate = delegateObj;
    [fetcher sendRequest:[DAJsonAPIUrl urlWithGetAtMeMessagesStart:start count:count]];
}

-(void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    DAMessageList *messageList = [[DAMessageList alloc] initWithDictionary:[DAJsonHelper objectAtPath:jsonDict path:jsonPathMessageList]];
    [self.delegate didFinishFetchingAtMeMessageList:messageList];
    self.delegate = nil;
}
@end
