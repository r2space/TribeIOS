//
//  DAAFHttpClient.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAHeader.h"

@interface DAAFHttpClient : AFHTTPClient

+ (DAAFHttpClient *)sharedClient;

- (void)imagePath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

@end
