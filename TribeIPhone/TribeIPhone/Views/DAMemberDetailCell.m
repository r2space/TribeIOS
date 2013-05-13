//
//  DAMemberDetailCell.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/18.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMemberDetailCell.h"

@implementation DAMemberDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(DAMemberDetailCell *)initWithMessage:(DAUser *)group tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAMemberDetailCell";
    
	DAMemberDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    if (group.photo != nil) {
        [DAPictureFetcher getPictureWiDelegate:cell PictureId:group.photo.small];
    }
    
    return cell;
}

- (void) didFinishFetchPicture:(NSString *)pictureId
{
    self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
}

@end
