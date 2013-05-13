//
//  DAFriendViewCell.m
//  tribe
//
//  Created by 李 林 on 2012/12/15.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DAMemberViewCell.h"

@implementation DAMemberViewCell

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


+ (DAMemberViewCell *)initWithMessage:(DAUser *)user tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAMemberViewCell";
    
	DAMemberViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    if (user.photo != nil) {
        [DAPictureFetcher getPictureWiDelegate:cell PictureId:user.photo.small];
    }
    
    return cell;
}

#pragma mark - DAPictureFetcherDelegate
-(void)didFinishFetchPicture:(NSString *)pictureId
{
    self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
}



@end