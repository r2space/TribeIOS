//
//  DAGroupDetailCell.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAGroupDetailCell.h"
#import "DAMessageLabel.h"
#import "DAHelper.h"

@implementation DAGroupDetailCell

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

- (IBAction)onNameClicked:(id)sender {
    if (self.nameClickedBlock != nil) {
        self.nameClickedBlock(_group._id);
    }
}

- (IBAction)onInviteClicked:(id)sender {
    if (self.inviteClickedBlock != nil) {
        self.inviteClickedBlock(_group._id);
    }
}

- (IBAction)onJoinClicked:(id)sender {
    if (self.joinClickedBlock != nil) {
        self.joinClickedBlock(_group._id);
    }
}
- (void)setJoinAndInviteBtn:(BOOL)isMember
{
    if ([@"1" isEqualToString:self.group.type]) {
        // group
        [self.btnJoin setHidden:NO];
        if (isMember) {
            [self.btnInvite setHidden:NO];
        } else {
            [self.btnInvite setHidden:YES];
        }
    } else {
        [self.btnJoin setHidden:YES];
        [self.btnInvite setHidden:YES];
    }
    
    NSString *title = isMember ? @"退出" : @"加入";
    [DAHelper setDefaultButtonStyle:self.btnJoin name:title];
    
    
}

+(DAGroupDetailCell *)initWithMessage:(DAGroup *)group tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAGroupDetailCell";    
    
	DAGroupDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    cell.group = group;
    
    [DAHelper setDefaultButtonStyle:cell.btnInvite name:@"邀请"];
    [DAHelper setDefaultButtonStyle:cell.btnJoin name:@"退出"];
    
    NSMutableString *members = [NSMutableString stringWithString:@"成员人数："];
    [members appendString:[NSString stringWithFormat:@"%d", group.member.count]];
    
    cell.lblMemberCount.text = members;
    
    if (group.photo != nil) {
        [[DAFileModule alloc] getPicture:group.photo.small callback:^(NSError *err, NSString *pictureId){
            cell.imgPortrait.image = [DACommon getCatchedImage:pictureId];
        }];
    }else {
        cell.imgPortrait.image = [UIImage imageNamed:@"group_blank.png"];
    }
    
    DAMessageLabel *label = [[DAMessageLabel alloc] initWithContent:group.description font:[UIFont systemFontOfSize:12] breakMode:NSLineBreakByCharWrapping maxFrame:CGRectMake(20, 120, 280, 5000.0f)];
    [label setTextColor:[UIColor grayColor]];
    [cell addSubview:label];
    
    return cell;
}

@end
