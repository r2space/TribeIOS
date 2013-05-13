//
//  DAShortmailStoryViewCell.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/29.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAShortmailStoryViewCell.h"

@implementation DAShortmailStoryViewCell

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

+(DAShortmailStoryViewCell *)initWithMessage:(DAShortmail *)shortmail tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAShortmailStoryViewCell";
    
	DAShortmailStoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
//    if (user.photo != nil) {
//        [DAPictureFetcher getPictureWiDelegate:cell PictureId:user.photo.small];
//    }
    
    return cell;
    
}

@end
