//
//  DAComment.h
//  TribeSDK
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAUser.h"


@interface CommentPart : Jastor
@property (retain, nonatomic) DAUser *createby;
@end

@interface DAComment : Jastor

@property (retain, nonatomic) NSNumber *type;
@property (retain, nonatomic) NSString *content;
@property (retain, nonatomic) NSString *contentType;
@property (retain, nonatomic) NSString *range;
@property (retain, nonatomic) CommentPart *part;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *editby;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *target;

-(DAUser *) getCreatUser;

@end
