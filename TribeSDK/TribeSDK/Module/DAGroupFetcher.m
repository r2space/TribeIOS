//
//  DAGroupFetcher.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupFetcher.h"

#define groupUrl @"/group/get.json?_id=%@"

@implementation DAGroupFetcher

- (void)getGroupById:(id)delegate gid:(NSString *)gid
{
    self.delegate = delegate;
    
    NSString *url = [NSString stringWithFormat:groupUrl, gid];
    [super sendRequest:[DARequestHelper httpRequest:url method:@"GET"]];

}

- (void)didFailLoading:(NSError *)error
{
    _printf(@"%@", error.userInfo);
}

- (void)didFinishLoading:(NSData *)data
{
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *groupsDict = [DAJsonHelper objectAtPath:jsonDict path:@"data"];
    
    DAGroup *group = [[DAGroup alloc] initWithDictionary:groupsDict];
    
    if (self.delegate != nil) {
        [self.delegate didFinishFetchingGroup:group];
    }
    
}


@end
