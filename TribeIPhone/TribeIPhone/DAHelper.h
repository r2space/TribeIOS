//
//  DAMessageHelper.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DAColor [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:204.0f/255.0f alpha:1.0f]

@interface DAHelper : NSObject

+ (NSString *) documentPath:(NSString *)file;
+ (BOOL) isFileExist:(NSString *)fullPahtFile;
+ (NSString *) fileanExtension:(NSString *)type;
+ (BOOL) isNetworkReachable;

@end
