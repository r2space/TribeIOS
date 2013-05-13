//
//  DAUserFetcher.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/18.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAUser.h"
#import "DAWebAccess.h"

@protocol DAUserFetcherrDelegate
- (void)didFinishFetchingUser:(DAUser *) user;
@end

@interface DAUserFetcher : DAWebAccess
- (void)getUserById:(id)delegate uid:(NSString *)uid;
@end
