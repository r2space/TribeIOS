//
//  DAUserFollowPoster.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/19.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAUserFollowPoster.h"


#define followUrl @"/user/follow.json?_id=%@"
#define unfollowUrl @"/user/unfollow.json?_id=%@"


@implementation DAUserFollowPoster

- (void)follow:(NSString *)uid delegateObj:(id)delegateObj
{
    self.delegate = delegateObj;
    
    NSString *url = [NSString stringWithFormat:followUrl, uid];
    NSDictionary *postData = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];


    [self sendPostRequest:[DARequestHelper httpRequest:url method:@"PUT"] withPostData:postData];
}

- (void)unfollow:(NSString *)uid delegateObj:(id)delegateObj
{
    self.delegate = delegateObj;
    
    NSString *url = [NSString stringWithFormat:unfollowUrl, uid];
    NSDictionary *postData = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];

    [self sendPostRequest:[DARequestHelper httpRequest:url method:@"PUT"] withPostData:postData];
}

- (void)didFinishLoading:(NSData *)data
{
//    NSDictionary *jsonDict = [DAJsonHelper decode:data];
//    NSDictionary *groupDict = [DAJsonHelper objectAtPath:jsonDict path:@"data"];
    
    if (self.delegate != nil) {
        [self.delegate didFinishFollow];
    }
}

@end
