//
//  DAPhotoFetcher.h
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"

@protocol DAPictureFetcherDelegate

-(void)didFinishFetchPicture:(NSString*) pictureId;

@end

@interface DAPictureFetcher : DAWebAccess
@property (strong, nonatomic) id<DAPictureFetcherDelegate> delegate;
@property (retain, nonatomic) NSString* pictureId;

+(void)getPictureWiDelegate:(id)delegateObj PictureId:(NSString *)pictureId;
@end
