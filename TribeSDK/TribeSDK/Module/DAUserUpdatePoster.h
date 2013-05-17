//
//  DAUserUpdatePoster.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DACommon.h"
#import "DAWebAccess.h"

@protocol DAUserUpdatePosterDelegate
- (void)didFinishUpdate;
@end

@interface DAUserUpdatePoster : DAWebAccess

@property (strong, nonatomic) id<DAUserUpdatePosterDelegate> delegate;
- (void)update:(NSDictionary *)user delegateObj:(id)delegateObj;

@end
