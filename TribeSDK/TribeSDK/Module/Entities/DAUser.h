//
//  DAUser.h
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DACommon.h"

@interface UserName : Jastor <NSCoding>

@property (retain, nonatomic) NSString *name_zh;
@property (retain, nonatomic) NSString *letter_zh;

@end

@interface UserPhoto : Jastor <NSCoding>

@property (retain, nonatomic) NSString *small;
@property (retain, nonatomic) NSString *middle;
@property (retain, nonatomic) NSString *big;

@end



@interface DAUser : Jastor <NSCoding>
// TODO 服务器返回的JSON结构中有的地方是id有的地方是_id，需要进行统一
@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) UserName *name;
@property (retain, nonatomic) UserPhoto *photo;
@property (retain, nonatomic) NSArray *following;
@property (retain, nonatomic) NSString *uid;

-(NSString *)getUserName;
-(NSString *)getUserPhotoId;
-(UIImage *) getUserPhotoImage;
-(BOOL) isUserPhotoCatched;
@end




