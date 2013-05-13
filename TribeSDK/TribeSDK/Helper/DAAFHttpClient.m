//
//  DAAFHttpClient.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"

@implementation DAAFHttpClient

// Singletons
+ (DAAFHttpClient *)sharedClient {
    
    static DAAFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DAAFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kRemote]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.sdk.cookie"];
    [self setDefaultHeader:@"cookie" value:cookie];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    // TODO: HTTPS对应
    //if ([[url scheme] isEqualToString:@"https"] && [[url host] isEqualToString:@"dreamarts.co.jp"]) {
    //    [self setDefaultSSLPinningMode:AFSSLPinningModePublicKey];
    //}
    
    return self;
}

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [self setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [super getPath:path parameters:parameters success:success failure:failure];
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
//    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;
    [super postPath:[self appendCsrf:path] parameters:parameters success:success failure:failure];
}

- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    self.parameterEncoding = AFJSONParameterEncoding;
    [super putPath:[self appendCsrf:path] parameters:parameters success:success failure:failure];
}

- (void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [super deletePath:[self appendCsrf:path] parameters:parameters success:success failure:failure];
}

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
{
    NSString *csrfPath = [self appendCsrf:path];
    return [super multipartFormRequestWithMethod:method path:csrfPath parameters:parameters constructingBodyWithBlock:block];
}

- (NSString *)appendCsrf:(NSString *)path
{
    NSString *csrftoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.sdk.csrftoken"];
    NSString *spliter = [path rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&";
    return [NSString stringWithFormat:@"%@%@_csrf=%@", path, spliter, csrftoken];
}

@end