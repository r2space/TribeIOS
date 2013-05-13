//
//  DAUserFollowerFetcher.h
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"
#import "DAUserList.h"

@protocol DAUserFollowerFetcherDelegate
-(void)didFinishFetchingUserFollowerList:(DAUserList *) userList;
@end

@interface DAUserFollowerFetcher : DAWebAccess <DAWebAccessProtocol>
@property (strong, nonatomic) id<DAUserFollowerFetcherDelegate> delegate;
+(void)getUserFollowerListByUser:(NSString *)userId start:(int)start count:(int)count withDelegate:(id)delegateObj;
@end
