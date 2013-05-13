//
//  DAComment.m
//  TribeSDK
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAComment.h"

@implementation CommentPart

@synthesize createby;

@end

@implementation DAComment
@synthesize _id,type,content,contentType,createat,createby,editat,editby,range,part;
-(DAUser *)getCreatUser
{
    return self.part.createby;
}
@end
