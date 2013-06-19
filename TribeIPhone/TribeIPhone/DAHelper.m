//
//  DAMessageHelper.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAHelper.h"

@implementation DAHelper


+ (NSString *) documentPath:(NSString *)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    return [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], file];
}


+ (BOOL) isFileExist:(NSString *)fullPahtFile
{
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = ([fileManager fileExistsAtPath:fullPahtFile isDirectory:&isDir] && !isDir);
    return fileExists;
}

+ (NSString *) fileanExtension:(NSString *)type
{
    NSMutableDictionary *mime = [[NSMutableDictionary alloc] init];
    [mime setObject:@"doc" forKey:@"application/msword"];
    [mime setObject:@"docx" forKey:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document"];
    [mime setObject:@"xls" forKey:@"application/vnd.ms-excel"];
    [mime setObject:@"xlsx" forKey:@"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"];
    [mime setObject:@"ppt" forKey:@"application/vnd.ms-powerpoint"];
    [mime setObject:@"pptx" forKey:@"application/vnd.openxmlformats-officedocument.presentationml.presentation"];
    [mime setObject:@"ppsx" forKey:@"application/vnd.openxmlformats-officedocument.presentationml.slideshow"];
    [mime setObject:@"pdf" forKey:@"application/pdf"];
    [mime setObject:@"rtf" forKey:@"application/rtf"];
    [mime setObject:@"zip" forKey:@"application/zip"];
    [mime setObject:@"bmp" forKey:@"image/bmp"];
    [mime setObject:@"gif" forKey:@"image/gif"];
    [mime setObject:@"jpeg" forKey:@"image/jpeg"];
    [mime setObject:@"png" forKey:@"image/png"];
    [mime setObject:@"tiff" forKey:@"image/tiff"];
    [mime setObject:@"txt" forKey:@"text/plain"];
    [mime setObject:@"avi" forKey:@"video/msvideo"];
    [mime setObject:@"mov" forKey:@"video/quicktime"];
    
    NSString *result = [mime objectForKey:type];
    if (result == nil) {
        result = @"file";
    }
    
    return [NSString stringWithFormat:@"%@.png", result];
}

+ (BOOL) isNetworkReachable
{
    return [[DAAFHttpClient sharedClient] isReachable];
}



+ (CQMFloatingController *) showPopup:(UIViewController *)viewController
{
    // Get shared floating controller, and customize if needed
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController setFrameColor:[UIColor darkGrayColor]];
    
    // Show floating controller with content
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *rootView = [window.rootViewController view];
    
    
    [floatingController showInView:rootView
         withContentViewController:viewController
                          animated:YES];
    return floatingController;
}

+ (void) hidePopup
{
    // Get shared floating controller, and customize if needed
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    
    [floatingController dismissAnimated:YES];
}


// 日期相关
+ (NSDate *) dateFromISODateString:(NSString *)isodate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"];
    return [dateFormatter dateFromString:isodate];
}

+ (NSString *) stringFromISODateString:(NSString *)isodate
{
    NSDate *date = [DAHelper dateFromISODateString:isodate];

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM月dd日 HH:mm"];
    return [format stringFromDate:date];
}

+ (NSString *) currentDateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format stringFromDate:[NSDate date]];
}

@end
