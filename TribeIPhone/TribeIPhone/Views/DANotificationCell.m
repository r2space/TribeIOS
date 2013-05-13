//
//  DANotificationCell.m
//  TribeIPhone
//
//  Created by kita on 13-5-3.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DANotificationCell.h"

@implementation DANotificationCell

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

+ (DANotificationCell *)initWithNotification:(DANotification *)notification tableView:(UITableView *)tableView
{
    NSString *identifier = @"DANotificationCell";
    DANotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    DAUser *user = notification.user;
    if ([user isUserPhotoCatched] || [user getUserPhotoId] == nil) {
        [DAPictureFetcher getPictureWiDelegate:cell PictureId:[user getUserPhotoId]];
    }
    
    cell.lblName.text = [user getUserName];
    cell.lblContent.text = notification.content;
    
    return cell;
}

#pragma mark - DAPictureFetcherDelegate
-(void)didFinishFetchPicture:(NSString *)pictureId
{
    self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
}
@end
