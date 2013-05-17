//
//  DAUser.m
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAUser.h"

@implementation UserName
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name_zh forKey:@"name_zh"];
    [aCoder encodeObject:self.letter_zh forKey:@"letter_zh"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.name_zh = [aDecoder decodeObjectForKey:@"name_zh"];
    self.letter_zh = [aDecoder decodeObjectForKey:@"letter_zh"];
    return self;
}
@end


@implementation UserPhoto
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.small forKey:@"small"];
    [aCoder encodeObject:self.middle forKey:@"middle"];
    [aCoder encodeObject:self.big forKey:@"big"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.small = [aDecoder decodeObjectForKey:@"small"];
    self.middle = [aDecoder decodeObjectForKey:@"middle"];
    self.big = [aDecoder decodeObjectForKey:@"big"];
    return self;
}
@end


@implementation DAUser
@synthesize id, _id;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self._id == nil || [@"" isEqualToString:self._id]) {
        self._id = self.id;
    }
    return self;
}

-(NSString *)getUserName
{
    return self.name.name_zh;
}

-(NSString *) getUserPhotoId
{
    return self.photo.big;
}

-(UIImage *) getUserDefaultPhotoImage
{
    return [UIImage imageNamed:@"second@2x.png"];
}

-(UIImage *) getUserPhotoImage
{
    return [DACommon getCatchedImage: [self getUserPhotoId] defaultImage:[self getUserDefaultPhotoImage]];
}

-(BOOL) isUserPhotoCatched
{
    return [DACommon isImageCatched:[self getUserPhotoId]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.following forKey:@"following"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.id = [aDecoder decodeObjectForKey:@"id"];
    [self set_id:[aDecoder decodeObjectForKey:@"_id"]];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.photo = [aDecoder decodeObjectForKey:@"photo"];
    self.following = [aDecoder decodeObjectForKey:@"following"];
    return self;
}

+(Class) following_class {
    return [NSString class];
}

@end
