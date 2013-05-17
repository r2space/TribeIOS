//
//  DAGroupJoinModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DACommon.h"
#import "DAGroup.h"
#import "DAWebAccess.h"

@protocol DAGroupJoinModuleDelegate
- (void)didFinishJoin:(DAGroup *) group;
@end

@interface DAGroupJoinModule : DAWebAccess

@property (strong, nonatomic) id<DAGroupJoinModuleDelegate> delegate;

- (void)join:(id)delegateObj gid:(NSString *)gid uid:(NSString *)uid;
- (void)leave:(id)delegateObj gid:(NSString *)gid uid:(NSString *)uid;

@end

