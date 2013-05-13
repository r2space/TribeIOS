//
//  DAImageAttachFetcher.m
//  TribeSDK
//
//  Created by kita on 13-4-17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAImageAttachFetcher.h"

@implementation DAImageAttachFetcher
-(void)getImageAttach:(NSString *)fileId withDelegate: (id)delegate
{
    self.delegate = delegate;
    self.fileId = fileId;
    [self sendRequest:[DAJsonAPIUrl urlWithGetPicture:fileId]];
}

-(void)didFinishLoading:(NSData *)data
{
    [DAJsonHelper dataToFile:data fileName:self.fileId];
    [self.delegate didFinishFetchingImageAttach:self.fileId];
}
@end
