//
//  DACommon.m
//  TribeSDK
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DACommon.h"

@implementation DACommon
+(NSString *)getCatchedImagePath:(NSString *)fileId
{
    if (fileId == nil) {
        return nil;
    }
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/%@", [path objectAtIndex:0], fileId];
}

+(BOOL)isImageCatched:(NSString *)fileId
{
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = ([fileManager fileExistsAtPath:[DACommon getCatchedImagePath:fileId] isDirectory:&isDir] && !isDir);
    return fileExists;
}

+(UIImage *)getCatchedImage:(NSString *)fileId
{
    if (![DACommon isImageCatched:fileId]) {
        return nil;
    }
    NSString *file = [DACommon getCatchedImagePath:fileId];
    return [UIImage imageWithContentsOfFile:file];
}

+(UIImage *)getCatchedImage:(NSString *)fileId defaultImage:(UIImage *)defaultImg
{
    UIImage* img = [DACommon getCatchedImage:fileId];
    if (img == nil) {
        return defaultImg;
    }
    return img;
}
@end
