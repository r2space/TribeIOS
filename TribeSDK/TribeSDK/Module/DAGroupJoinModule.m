//
//  DAGroupJoinModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupJoinModule.h"


#define joinUrl @"/group/join.json?gid=%@&uid=%@"
#define leaveUrl @"/group/leave.json?gid=%@&uid=%@"

@implementation DAGroupJoinModule

- (void)join:(id)delegateObj gid:(NSString *)gid uid:(NSString *)uid
{
    self.delegate = delegateObj;
    
    NSString *url = [NSString stringWithFormat:joinUrl, gid, uid];
    [super sendPostRequest:[DARequestHelper httpRequest:url method:@"PUT"] withPostData:nil];
}

- (void)leave:(id)delegateObj gid:(NSString *)gid uid:(NSString *)uid
{
    self.delegate = delegateObj;

    NSString *url = [NSString stringWithFormat:leaveUrl, gid, uid];
    [super sendPostRequest:[DARequestHelper httpRequest:url method:@"PUT"] withPostData:nil];
}

- (void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *groupDict = [DAJsonHelper objectAtPath:jsonDict path:@"data"];
    
    DAGroup *group = [[DAGroup alloc] initWithDictionary:groupDict];
    
    if (self.delegate != nil) {
        [self.delegate didFinishJoin:group];
    }
}

@end
