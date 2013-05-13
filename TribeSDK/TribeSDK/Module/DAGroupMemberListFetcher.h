//
//  DAGroupMemberListFetcher.h
//  tribe
//
//  Created by kita on 13-4-14.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"
#import "DAUserList.h"

@protocol DAGroupMemberListFetcherDelegate

-(void)didFinishFetchingGroupMemberList:(DAUserList *) userList;

@end

@interface DAGroupMemberListFetcher : DAWebAccess <DAWebAccessProtocol>
@property (strong, nonatomic) id<DAGroupMemberListFetcherDelegate> delegate;
+(void)getUserListInGroup:(NSString *)gid start:(int)start count:(int)count withDelegate:(id)delegateObj;
@end
