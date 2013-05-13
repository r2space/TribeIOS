//
//  DAUserUpdatePoster.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAUserUpdatePoster.h"


#define updateUrl @"/user/update.json?_id=%@"

@implementation DAUserUpdatePoster

- (void)update:(NSDictionary *)user delegateObj:(id)delegateObj
{
    self.delegate = delegateObj;

    NSMutableDictionary * postData = [[NSMutableDictionary alloc] initWithDictionary:user];

    NSString *photoId = [user objectForKey:@"fid"];
    NSString *name = [user objectForKey:@"name"];
    
    if (photoId != nil) {
        
        // 转换成
        NSDictionary *photo = [NSDictionary dictionaryWithObjectsAndKeys:photoId, @"fid",
                               @"0", @"x",
                               @"0", @"y",
                               @"320", @"width", nil];
        [postData setObject:photo forKey:@"photo"];
    }
    if (name != nil) {
        NSDictionary *nameObj = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name_zh", nil];
       [postData setObject:nameObj forKey:@"name"];
    }

    NSString *url = [NSString stringWithFormat:updateUrl, [user objectForKey:@"_id"]];
    [self sendPostRequest:[DARequestHelper httpRequest:url method:@"PUT"] withPostData:postData];

}

- (void)didFinishLoading:(NSData *)data
{
    if (self.delegate != nil) {
        [self.delegate didFinishUpdate];
    }
}

@end
