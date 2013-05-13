//
//  DAFilePoster.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAWebAccess.h"
#import "DAHeader.h"
#import "DAFile.h"
#import "DAFileList.h"


@protocol DAFilePosterDelegate
- (void)didFinishUpload:(DAFile *)file;
@end

@interface DAFilePoster : DAWebAccess

- (void)upload:(UIImage *)image delegateObj:(id)delegateObj;

@end
