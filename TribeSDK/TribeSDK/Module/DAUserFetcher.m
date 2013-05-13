//
//  DAUserFetcher.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/18.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAUserFetcher.h"

#define userUrl @"/user/get.json?_id=%@"

@implementation DAUserFetcher

- (void)getUserById:(id)delegate uid:(NSString *)uid
{
    self.delegate = delegate;
    
    NSString *url = [NSString stringWithFormat:userUrl, uid];
    [super sendRequest:[DARequestHelper httpRequest:url method:@"GET"]];
}

- (void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *usersDict = [DAJsonHelper objectAtPath:jsonDict path:@"data"];
    
    DAUser *user = [[DAUser alloc] initWithDictionary:usersDict];
    
    if (self.delegate != nil) {
        [self.delegate didFinishFetchingUser:user];
    }
}

- (void)didFailLoading:(NSError *)error
{
    _printf(@"%@", error.userInfo);
}

@end
