//
//  DAShortmailViewCell.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAShortmailViewCell.h"

@implementation DAShortmailViewCell

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


+(DAShortmailViewCell *)initWithMessage:(DAUser *)user tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAShortmailViewCell";
    
	DAShortmailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.lblName.text = user.name.name_zh;
    if (user.photo != nil) {
        [DAPictureFetcher getPictureWiDelegate:cell PictureId:user.photo.small];
    }
    return cell;

}

- (void)didFinishFetchPicture:(NSString *)pictureId
{
    self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
}

@end
