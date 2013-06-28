//
//  DAMemberDetailCell.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/18.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMemberDetailCell.h"
#import "DAHelper.h"

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

+(DAMemberDetailCell *)initWithMessage:(DAUser *)user tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAMemberDetailCell";
    
	DAMemberDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.user = user;
    if (user.photo != nil) {
        [[DAFileModule alloc] getPicture:user.photo.big callback:^(NSError *err, NSString *pictureId){
            cell.imgPortrait.image = [DACommon getCatchedImage:pictureId];
        }];
    }
    
    if ([[DALoginModule getLoginUserId] isEqualToString:user._id]) {
        [cell.btnFollow setHidden:YES];
    } else {
        [cell.btnFollow setHidden:NO];
    }
    
    NSMutableString *followCnt = [NSMutableString stringWithString:@"粉丝："];
    [followCnt appendString:[NSString stringWithFormat:@"%d", user.follower.count]];
    [followCnt appendString:@"     "];
    [followCnt appendString:@"关注的人："];
    [followCnt appendString:[NSString stringWithFormat:@"%d", user.following.count]];
    cell.lblFollowCount.text = followCnt;
    
    [DAHelper setDefaultButtonStyle:cell.btnFollow name:@"关注"];
    
    return cell;
}

-(void)setFollow:(BOOL)isFollowed
{
    NSString *title = isFollowed ? @"取消关注" : @"关注";
    [DAHelper setDefaultButtonStyle:self.btnFollow name:title];
}

- (IBAction)onNameClicked:(id)sender {
    if (self.userClickedBlock != nil) {
        self.userClickedBlock(_user._id);
    }
}

- (IBAction)onFollowClicked:(id)sender {
    if (self.followClickedBlock != nil) {
        self.followClickedBlock(_user._id);
    }
}
@end
