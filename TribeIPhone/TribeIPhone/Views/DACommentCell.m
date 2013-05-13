//
//  DACommentCell.m
//  TribeIPhone
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DACommentCell.h"

@implementation DACommentCell

+(float)cellHeightWithComment:(DAMessage *)comment
{
    float height = 0;
    DAMessageLabel *label = [DACommentCell commentLabelWithContent:comment.content];
    height += label.frame.size.height;
    //top
    height += 30;
    
    // bottom
    height += 10;
    
    return height;
}

+(DACommentCell *)initWithComment:(DAMessage *)comment tableView:(UITableView *)tableView
{
    NSString *identifier = @"DACommentCell";
    DACommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    DAUser *user = comment.part.createby;
    if ([user isUserPhotoCatched] || [user getUserPhotoId] == nil) {
        cell.imgPortrait.image = [user getUserPhotoImage];
    } else {
        [DAPictureFetcher getPictureWiDelegate:cell PictureId:[user getUserPhotoId]];
    }
    
    cell.lblCreateBy.text = [user getUserName];
    
    DAMessageLabel *label = [DACommentCell commentLabelWithContent:comment.content];
    [cell.lblComment removeFromSuperview];
    cell.lblComment = label;
    [cell addSubview:cell.lblComment];
    
    return cell;
}

+(DAMessageLabel *)commentLabelWithContent:(NSString *)content
{
    return [[DAMessageLabel alloc] initWithContent:content font:[UIFont systemFontOfSize:14] breakMode:NSLineBreakByCharWrapping maxFrame:CGRectMake(55,30,253,5000)];
}

#pragma mark - DAPictureFetcherDelegate
-(void)didFinishFetchPicture:(NSString *)pictureId
{
    self.imgPortrait.image = [DACommon getCatchedImage:pictureId];
}
@end
