//
//  DAMessageList.m
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAMessageList.h"

@implementation DAMessageList
@synthesize total, items;

+(Class) items_class {
    return [DAMessage class];
}
@end
