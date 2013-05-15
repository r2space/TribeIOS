//
//  DAGroupCell.m
//  TribeIPhone
//
//  Created by kita on 13-4-24.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAGroupCell.h"

@implementation DAGroupCell

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

+(DAGroupCell *)initWithGroup:(DAGroup *)group tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAGroupCell";
    
	DAGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    cell.lblName.text = group.name.name_zh;
    
    if (group.photo != nil) {
        [[DAFileModule alloc] getPicture:group.photo.small callback:^(NSError *err, NSString *pictureId){
            cell.imgPortrait.image = [DACommon getCatchedImage:pictureId];
        }];
    }
    
    return cell;
}

@end
