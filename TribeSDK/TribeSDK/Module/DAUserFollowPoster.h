//
//  DAUserFollowPoster.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/19.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DACommon.h"
#import "DAWebAccess.h"

@protocol DAUserFollowPosterDelegate
- (void)didFinishFollow;
@end


@interface DAUserFollowPoster : DAWebAccess

@property (strong, nonatomic) id<DAUserFollowPosterDelegate> delegate;
- (void)follow:(NSString *)uid delegateObj:(id)delegateObj;
- (void)unfollow:(NSString *)uid delegateObj:(id)delegateObj;

@end
