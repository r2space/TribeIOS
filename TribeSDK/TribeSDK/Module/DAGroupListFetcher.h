//
//  DAGroupListFetcher.h
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"
#import "DAGroupList.h"

@protocol DAGroupListFetcherDelegate
- (void)didFinishFetchingGroupList:(DAGroupList *) groupList;
@end

@interface DAGroupListFetcher : DAWebAccess <DAWebAccessProtocol>
@property (strong, nonatomic) id<DAGroupListFetcherDelegate> delegate;
- (void)getGroupListWithDelegate:(id)delegateObj;
- (void)getGroupListByUser:(NSString *)uid start:(NSInteger)start count:(NSInteger)count delegate:(id)delegateObj;

@end
