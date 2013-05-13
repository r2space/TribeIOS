//
//  DAUserListFetcher.h
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"
#import "DAUserList.h"

@protocol DAUserListFetcherDelegate

-(void)didFinishFetchingUserList:(DAUserList *) userList;

@end

@interface DAUserListFetcher : DAWebAccess <DAWebAccessProtocol>
@property (strong, nonatomic) id<DAUserListFetcherDelegate> delegate;
+(void)getUserListStart:(int)start count:(int)count withDelegate:(id)delegateObj;
@end
