//
//  DAGroupViewCell.m
//  tribe
//
//  Created by 李 林 on 2012/12/13.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DAGroupViewCell.h"

@implementation DAGroupViewCell

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


+(DAGroupViewCell *)initWithMessage:(DAGroup *)group tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAGroupViewCell";
    
	DAGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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

#pragma mark - DAPictureFetcherDelegate
-(void)didFinishFetchPicture:(NSString *)pictureId
{
    self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
}



@end
