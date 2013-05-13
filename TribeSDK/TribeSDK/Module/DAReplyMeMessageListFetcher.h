//
//  DAReplyMeMessageListFetcher.h
//  tribe
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"
#import "DAMessageList.h"

@protocol DAReplyMeMessageListFetcherDelegate

-(void)didFinishFetchingReplyMeMessageList:(DAMessageList *) messageList;

@end

@interface DAReplyMeMessageListFetcher : DAWebAccess
@property (strong, nonatomic) id<DAReplyMeMessageListFetcherDelegate> delegate;
+(void)getReplyMeMessagesStart:(int)start count: (int)count withDelegate:(id)delegateObj;

@end
