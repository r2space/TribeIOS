//
//  DAGroupUpdatePoster.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupUpdatePoster.h"

#define updateUrl @"/group/update.json?_id=%@"
#define createUrl @"/group/create.json"

@implementation DAGroupUpdatePoster

- (void)create:(DAGroup *)group delegateObj:(id)delegateObj
{
    self.delegate = delegateObj;
    
    NSMutableDictionary * postData = [[NSMutableDictionary alloc] init];
    
    if (group.name != nil) {
        NSDictionary *name = [NSDictionary dictionaryWithObjectsAndKeys:group.name.name_zh, @"name_zh", nil];
        [postData setObject:name forKey:@"name"];
    }
    
    if (group.photo != nil) {
        
        // 转换
        NSDictionary *photo = [NSDictionary dictionaryWithObjectsAndKeys:group.photo.big, @"fid",
                               @"0", @"x",
                               @"0", @"y",
                               @"320", @"width", nil];
        [postData setObject:photo forKey:@"photo"];
    }

    if (group.description != nil) {
        [postData setObject:group.description forKey:@"description"];
    }

    [self sendPostRequest:[DARequestHelper httpRequest:createUrl method:@"POST"] withPostData:postData];
}

- (void)update:(DAGroup *)group delegateObj:(id)delegateObj
{
    self.delegate = delegateObj;
    NSMutableDictionary * postData = [NSMutableDictionary dictionaryWithObjectsAndKeys:group._id, @"_id",
                                      group.description, @"description",
                                      nil];

    if (group.name != nil) {
        NSDictionary *name = [NSDictionary dictionaryWithObjectsAndKeys:group.name.name_zh, @"name_zh",
                               nil];
        [postData setObject:name forKey:@"name"];
    }
    
    if (group.photo != nil) {
        
        // 转换
        NSDictionary *photo = [NSDictionary dictionaryWithObjectsAndKeys:group.photo.big, @"fid",
                               @"0", @"x",
                               @"0", @"y",
                               @"320", @"width", nil];
        [postData setObject:photo forKey:@"photo"];
    }

    NSString *url = [NSString stringWithFormat:updateUrl, group._id];
    [self sendPostRequest:[DARequestHelper httpRequest:url method:@"PUT"] withPostData:postData];

}

- (void)didFinishLoading:(NSData *)data
{
    if (self.delegate != nil) {
        [self.delegate didFinishUpdateGroup];
    }
}

@end
