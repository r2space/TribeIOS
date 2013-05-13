//
//  DAGroupUpdatePoster.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAWebAccess.h"
#import "DAHeader.h"
#import "DAGroup.h"

@protocol DAGroupUpdatePosterDelegate
- (void)didFinishUpdateGroup;
@end

@interface DAGroupUpdatePoster : DAWebAccess

@property (strong, nonatomic) id<DAGroupUpdatePosterDelegate> delegate;
- (void)update:(DAGroup *)group delegateObj:(id)delegateObj;
- (void)create:(DAGroup *)group delegateObj:(id)delegateObj;

@end
