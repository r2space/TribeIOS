//
//  DAUserFollowingFetcher.h
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"

#import "DAUserList.h"

@protocol DAUserFollowingFetcherDelegate
-(void)didFinishFetchingUserFollowingList:(DAUserList *) userList;
@end

@interface DAUserFollowingFetcher : DAWebAccess <DAWebAccessProtocol>
@property (strong, nonatomic) id<DAUserFollowingFetcherDelegate> delegate;
+(void)getUserFollowingListByUser:(NSString *)userId start:(int)start count:(int)count withDelegate:(id)delegateObj;
@end
