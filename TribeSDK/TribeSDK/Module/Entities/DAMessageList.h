//
//  DAMessageList.h
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "Jastor.h"
#import "DAMessage.h"

@interface DAMessageList : Jastor
@property (retain, nonatomic) NSNumber *total;
@property (retain, nonatomic) NSArray *items;
@end
