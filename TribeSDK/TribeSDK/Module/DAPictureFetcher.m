//
//  DAPhotoFetcher.m
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAPictureFetcher.h"

#define urlGetPicture @"/picture/%@"

@implementation DAPictureFetcher
@synthesize pictureId;

+(NSMutableURLRequest *) urlWithGetPictureById:(NSString *)pictureId
{
    NSString *url = [NSString stringWithFormat:urlGetPicture, pictureId];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(void)getPictureWiDelegate:(id)delegateObj PictureId:(NSString *)pictureId
{
    if (pictureId == nil) {
        return;
    }
    DAPictureFetcher *fecture = [[DAPictureFetcher alloc] init];
    fecture.delegate = delegateObj;
    fecture.pictureId = pictureId;
    [fecture sendRequest:[DAPictureFetcher urlWithGetPictureById:pictureId]];
}

-(void)didFinishLoading:(NSData *)data
{
    [DAJsonHelper dataToFile:data fileName:self.pictureId];
    [self.delegate didFinishFetchPicture:self.pictureId];
}
@end
