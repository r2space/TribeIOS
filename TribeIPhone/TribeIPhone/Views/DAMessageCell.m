//
//  DAMessageCell.m
//  TribeIPhone
//
//  Created by kita on 13-4-15.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMessageCell.h"

#define CONTENT_LABEL_TO_TOP 22.0f
#define CONTENT_LABEL_TO_LEFT 55.0f
#define BUTTON_AREA_HEIGHT 43.0f

@interface DAMessageCell ()
{
    
}
@end

@implementation DAMessageCell


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

-(CGFloat) cellHeight
{
//    return self.frame.size.height;
    return self.lblMessage.frame.size.height + self.atArea.frame.size.height + CONTENT_LABEL_TO_TOP + BUTTON_AREA_HEIGHT;
}


+(DAMessageCell *)initWithMessage:(DAMessage *)message tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAMessageCell";
    
	DAMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    [cell cellInitWithMessage:message];
    
    
    return cell;
}

+(float)cellHeightWithMessage:(DAMessage *)message
{
    float maxWidth = 253.0f;
    float height = 0;
    
    // top
    height += CONTENT_LABEL_TO_TOP;
    
    // content
    
    float lblMaxHeight = 18.0f * 5; // show 5 lines
    DAMessageLabel *label = [[DAMessageLabel alloc] initWithContent:message.content font:[UIFont systemFontOfSize:14] breakMode:NSLineBreakByTruncatingTail maxFrame:CGRectMake(CONTENT_LABEL_TO_LEFT,height,maxWidth,lblMaxHeight)];
    height += label.frame.size.height;
    
    DAMessageAtView *view = [[DAMessageAtView alloc] initWithMessage:message frame:CGRectMake(CONTENT_LABEL_TO_LEFT, height, maxWidth, 0)];
    height += view.frame.size.height;
    
    if ([message_contenttype_document isEqualToString:message.contentType] || [message_contenttype_file isEqualToString:message.contentType]) {
        DAMessageFileView *fview = [[DAMessageFileView alloc] initWithMessage:message frame:CGRectMake(CONTENT_LABEL_TO_LEFT + 10, height, maxWidth - 20, 0)];
        height += fview.frame.size.height;
    }
    
    if ([message_contenttype_image isEqualToString:message.contentType]) {
        height += 66;
    }
    
    // bottom
    height += BUTTON_AREA_HEIGHT;
    
    return height;
}

-(void) cellInitWithMessage:(DAMessage *)message
{
    touchContents = [[NSMutableDictionary alloc] init];
    
    DAUser *user = message.part.createby;
    
    //    if ([user isUserPhotoCatched] || [user getUserPhotoId] == nil) { // TODO catched photo
    if ([user getUserPhotoId] == nil) {
        self.imgPortrait.image = [user getUserPhotoImage];
    } else {
        [[DAFileModule alloc] getPicture:[user getUserPhotoId] callback:^(NSError *err, NSString *pictureId){
            self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
        }];
    }
    [touchContents setObject:user forKey:@"createby"];
    
    if(message.range != nil && [message getPublicRange] != nil){
        [self.groupView setHidden:NO];
        DAGroup *group = [message getPublicRange];
        self.lblRange.text = group.name.name_zh;
        [touchContents setObject:group forKey:@"range"];
    } else {
        [self.groupView setHidden:YES];
    }
    
    self.lblBy.text = [user getUserName];
    
    
    self.lblCommentCount.text = [NSString stringWithFormat:@"%@",[message getReplyCount]];
    self.lblForwardCount.text = [NSString stringWithFormat:@"%@",[message getForwardCount]];
    
    float maxWidth = 253.0f;
    float height = 0;
    
    
    // content
    height += CONTENT_LABEL_TO_TOP;
    UIFont *font = [UIFont systemFontOfSize:14];
    float lblMaxHeight = font.lineHeight * 5; // show 5 lines
    DAMessageLabel *label = [[DAMessageLabel alloc] initWithContent:message.content font:font breakMode:NSLineBreakByTruncatingTail maxFrame:CGRectMake(CONTENT_LABEL_TO_LEFT,height,maxWidth,lblMaxHeight)];
    [self.lblMessage removeFromSuperview];
    self.lblMessage = label;
    [self addSubview:self.lblMessage];
    height += label.frame.size.height;
    
    
    // at view
    DAMessageAtView *view = [[DAMessageAtView alloc] initWithMessage:message frame:CGRectMake(CONTENT_LABEL_TO_LEFT, height, maxWidth, 0)];
    [self.atArea removeFromSuperview];
    view.delegate = self;
    self.atArea = view;
    [self addSubview:view];
    height += view.frame.size.height;
    
    if ([message_contenttype_document isEqualToString:message.contentType] || [message_contenttype_file isEqualToString:message.contentType]) {
        DAMessageFileView *fview = [[DAMessageFileView alloc] initWithMessage:message frame:CGRectMake(CONTENT_LABEL_TO_LEFT + 10, height, maxWidth - 20, 0)];
        [self.fileArea removeFromSuperview];
        self.fileArea = fview;
        [self addSubview:fview];
        height += fview.frame.size.height;
    }
    
    
    if ([message_contenttype_image isEqualToString:message.contentType]) {
        if (message.attach.count > 0) {
            MessageAttach *file = [message.attach objectAtIndex:0];
            if ([DACommon isImageCatched:file.fileid]) {
                self.imgAttach.image = [DACommon getCatchedImage:file.fileid];
            } else {
                [[DAFileModule alloc] getPicture:file.fileid callback:^(NSError *err, NSString *pictureId){
                    self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
                }];
            }
            [self.imgAttach setHidden:NO];
        }
    } else {
        [self.imgAttach setHidden:YES];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.parentController != nil) {
        UITouch *touch = event.allTouches.anyObject;
        CGPoint touchPoint = [touch locationInView:self];
        
        if (CGRectContainsPoint(self.groupView.frame,touchPoint)) {
            DAGroup *group = (DAGroup *)[touchContents objectForKey:@"range"];
            [self pushGroupDetailCtrlToParentNavCtrl:group];
            return;
        }
        
        if (CGRectContainsPoint(self.imgPortrait.frame, touchPoint) || CGRectContainsPoint(self.lblBy.frame, touchPoint)) {
            DAUser *user = (DAUser *)[touchContents objectForKey:@"createby"];
            [self pushMemberDetailCtrlToParentNavCtrl:user];
            return;
        }
    }
    
    [self.nextResponder touchesEnded:touches withEvent:event];
}

-(void)pushMemberDetailCtrlToParentNavCtrl:(DAUser *)user
{
    if (self.parentController != nil) {
        DAMemberDetailViewController *memberDetailViewController =[[DAMemberDetailViewController alloc]initWithNibName:@"DAMemberDetailViewController" bundle:nil];
        memberDetailViewController.hidesBottomBarWhenPushed = YES;
        memberDetailViewController.uid = user._id ;
        
        [self.parentController.navigationController pushViewController:memberDetailViewController animated:YES];
    }
}

-(void)pushGroupDetailCtrlToParentNavCtrl:(DAGroup *)group
{
    if (self.parentController != nil) {
        DAGroupDetailViewController *groupDetailViewController =[[DAGroupDetailViewController alloc]initWithNibName:@"DAGroupDetailViewController" bundle:nil];
        groupDetailViewController.hidesBottomBarWhenPushed = YES;
        groupDetailViewController.gid = group._id ;
        
        [self.parentController.navigationController pushViewController:groupDetailViewController animated:YES];
    }
}

#pragma mark - DAMessageAtViewDelegate
-(void)atUserClicked:(DAUser *)user
{
    NSLog(@"atuser: %@", user._id);
    [self pushMemberDetailCtrlToParentNavCtrl:user];
}

-(void)atGroupClicked:(DAGroup *)group
{
    NSLog(@"atgroup: %@", group._id);
    [self pushGroupDetailCtrlToParentNavCtrl:group];
}

@end
