//
//  DAReplyMeMessageListFetcher.m
//  tribe
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAReplyMeMessageListFetcher.h"
#import "DAJsonAPIUrl.h"

@implementation DAReplyMeMessageListFetcher
+(void)getReplyMeMessagesStart:(int)start count: (int)count withDelegate:(id)delegateObj
{
    DAReplyMeMessageListFetcher *fetcher = [[DAReplyMeMessageListFetcher alloc] init];
    fetcher.delegate = delegateObj;
    [fetcher sendRequest:[DAJsonAPIUrl urlWithGetReplyMeMessagesStart:start count:count]];
}

-(void)didFinishLoading:(NSData *)data {
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    DAMessageList *messageList = [[DAMessageList alloc] initWithDictionary:[DAJsonHelper objectAtPath:jsonDict path:jsonPathMessageList]];
    [self.delegate didFinishFetchingReplyMeMessageList:messageList];
    self.delegate = nil;
}
@end
