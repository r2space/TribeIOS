//
//  DAAtMeMessageListFetcher.h
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"
#import "DAMessageList.h"

@protocol DAAtMeMessageListFetcherDelegate
-(void)didFinishFetchingAtMeMessageList:(DAMessageList *) messageList;
@end

@interface DAAtMeMessageListFetcher : DAWebAccess
@property(strong, nonatomic) id<DAAtMeMessageListFetcherDelegate> delegate;
+(void)getAtMeMessagesStart:(int)start count: (int)count withDelegate:(id)delegateObj;
@end
