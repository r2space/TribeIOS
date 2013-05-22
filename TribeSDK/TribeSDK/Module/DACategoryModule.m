//
//  DADataStore.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DACategoryModule.h"


#define kURLGetCategory @"/category/get.json?id=%@"


@implementation DACategoryModule

- (void)getCategory:(NSString *)categoryId
           callback:(void (^)(NSError *error, DACategory *category))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetCategory, categoryId];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DACategory alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
