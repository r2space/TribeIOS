//
//  DAPurchaseModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAPurchaseModule.h"

#define kURLPurchaseAdd     @"/app/purchase/add.json"
#define kURLPurchaseUpdate  @"/app/purchase/update.json?id=%@"
#define kURLPurchase        @"/app/purchase/get.json?date=%@"
#define kURLPurchaseList    @"/app/purchase/list.json?from=%@&start=%d&limit=%d"

@implementation DAPurchaseModule

- (void)add:(DAPurchase *)daily callback:(void (^)(NSError *error, DAPurchase *daily))callback
{
    NSDictionary *params = [daily toDictionary];
    
    [[DAAFHttpClient sharedClient] postPath:kURLPurchaseAdd parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPurchase alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)update:(DAPurchase *)daily callback:(void (^)(NSError *error, DAPurchase *daily))callback
{
    NSDictionary *params = [daily toDictionary];
    NSString *path = [NSString stringWithFormat:kURLPurchaseUpdate, daily._id];
    
    [[DAAFHttpClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPurchase alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

// 获取指定日期开始的数据
- (void)getList:(NSString *)from
          start:(int)start
          count:(int)count
       callback:(void (^)(NSError *error, DAPurchaseList *list))callback
{
    NSString *m = [DARequestHelper uriEncodeForString:from];
    NSString *path = [NSString stringWithFormat:kURLPurchaseList, m, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPurchaseList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)getByDate:(NSString *)date
         callback:(void (^)(NSError *error, DAPurchase *purchase))callback
{
    NSString *d = [DARequestHelper uriEncodeForString:date];
    NSString *path = [NSString stringWithFormat:kURLPurchase, d];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPurchase alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


@end
