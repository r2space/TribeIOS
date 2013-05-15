//
//  DACommon.h
//  TribeSDK
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DACommon : NSObject
+(NSString *)getCatchedImagePath:(NSString *)fileId;
+(BOOL) isImageCatched:(NSString *)fileId;
+(UIImage *) getCatchedImage:(NSString *)fileId;
+(UIImage *) getCatchedImage:(NSString *)fileId defaultImage:(UIImage *)defaultImg;
+ (NSString *) dataToFile:(NSData *)data fileName:(NSString *)fileName;
@end
