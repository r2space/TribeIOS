//
//  DAGroup.h
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DACommon.h"

@interface GroupName : Jastor
@property(retain, nonatomic) NSString* letter_zh;
@property(retain, nonatomic) NSString* name_zh;
@end


@interface GroupPhoto : Jastor
@property (retain, nonatomic) NSString *small;
@property (retain, nonatomic) NSString *middle;
@property (retain, nonatomic) NSString *big;
@end


@interface DAGroup : Jastor
// TODO 服务器返回的JSON结构中有的地方是id有的地方是_id，需要进行统一
@property (retain, nonatomic) NSString* _id;
@property (retain, nonatomic) NSString* id;
@property (retain, nonatomic) GroupName* name;
@property (retain, nonatomic) NSArray* member;
@property (retain, nonatomic) GroupPhoto* photo;
@property (retain, nonatomic) NSString* description;
-(UIImage *) getGroupPhotoImage;
@end
