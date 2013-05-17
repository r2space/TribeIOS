//
//  DAGroupFetcher.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroup.h"
#import "DAWebAccess.h"

@protocol DAGroupFetcherDelegate
- (void)didFinishFetchingGroup:(DAGroup *) group;
@end

@interface DAGroupFetcher : DAWebAccess

- (void)getGroupById:(id)delegate gid:(NSString *)gid;

@end
