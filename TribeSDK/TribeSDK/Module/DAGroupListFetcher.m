//
//  DAGroupListFetcher.m
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAGroupListFetcher.h"
#import "DAJsonAPIUrl.h"

#define groupListByUser @"/group/list.json?joined=true&start=%d&count=%d&uid=%@"

@implementation DAGroupListFetcher

-(void)getGroupListWithDelegate:(id)delegateObj
{
    self.delegate = delegateObj;
    [self sendRequest:[DAJsonAPIUrl urlWithGetGroupList]];
}

-(void)getGroupListByUser:(NSString *)uid start:(NSInteger)start count:(NSInteger)count delegate:(id)delegateObj
{
    self.delegate = delegateObj;
    
    NSString *url = [NSString stringWithFormat:groupListByUser, start, count, uid];
    [super sendRequest:[DARequestHelper httpRequest:url method:@"GET"]];    
}


-(void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *groupsDict = [DAJsonHelper objectAtPath:jsonDict path:jsonPathGroupList];
    
//    NSLog(@"%@", groupsDict);
    DAGroupList *groups = [[DAGroupList alloc] initWithDictionary:groupsDict];
    
    [self.delegate didFinishFetchingGroupList:groups];
    self.delegate = nil;
}

@end
