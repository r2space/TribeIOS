//
//  DACommentList.m
//  TribeSDK
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DACommentList.h"

@implementation DACommentList
@synthesize total, items;

+(Class) items_class {
    return [DAComment class];
}
@end
