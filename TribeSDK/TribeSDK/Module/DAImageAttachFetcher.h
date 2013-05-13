//
//  DAImageAttachFetcher.h
//  TribeSDK
//
//  Created by kita on 13-4-17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAWebAccess.h"
#import "DAJsonAPIUrl.h"

@protocol DAImageAttachFetcherDelegate
-(void)didFinishFetchingImageAttach:(NSString *)fileId;
@end

@interface DAImageAttachFetcher : DAWebAccess<DAWebAccessProtocol>
@property (strong, nonatomic) id<DAImageAttachFetcherDelegate> delegate;
@property (retain, nonatomic) NSString* fileId;

-(void)getImageAttach:(NSString *)fileId withDelegate: (id)delegate;
@end
