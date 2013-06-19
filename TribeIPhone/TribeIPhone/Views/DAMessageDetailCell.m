//
//  DAMessageDetailCell.m
//  TribeIPhone
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMessageDetailCell.h"

@implementation DAMessageDetailCell


+(DAMessageDetailCell *) initWithMessage:(DAMessage *)message tableView:(UITableView *)tableView
{
    NSString *identifier = @"DAMessageDetailCell";
    DAMessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    float offset = 8;
    float height = 0;
    float maxWidth = 320 - offset*2;
    // content
    DAMessageLabel *label = [[DAMessageLabel alloc] initWithContent:message.content font:[UIFont systemFontOfSize:16] breakMode:NSLineBreakByCharWrapping maxFrame:CGRectMake(offset, height, maxWidth, 5000.0f)];
    [cell.lblMessage removeFromSuperview];
    cell.lblMessage = label;
    [cell addSubview:cell.lblMessage];
    height += label.frame.size.height;
    
    // at view
    DAMessageAtView *view = [[DAMessageAtView alloc] initWithMessage:message frame:CGRectMake(offset, height, maxWidth, 5000)];
    [cell.atArea removeFromSuperview];
    cell.atArea = view;
    [cell addSubview:view];
    height += view.frame.size.height;
    
    if ([message_contenttype_document isEqualToString:message.contentType] || [message_contenttype_file isEqualToString:message.contentType]) {
        DAMessageFileView *fview = [[DAMessageFileView alloc] initWithMessage:message frame:CGRectMake(20, height, maxWidth - 40, 0)];
        [cell.fileArea removeFromSuperview];
        cell.fileArea = fview;
        [cell addSubview:fview];
        height += fview.frame.size.height;
    }
    if ([message_contenttype_image isEqualToString:message.contentType]) {
        if (message.attach.count > 0) {
            
            NSMutableArray *ids = [[NSMutableArray alloc] init];
            for (MessageAttach *file in message.attach) {
                [ids addObject:file.fileid];
            }
            [cell.scrollView renderWithPictureIds:ids];
            [cell.scrollView setHidden:NO];
        }
    } else {
        [cell.scrollView setHidden:YES];
    }
    
    return cell;
}

-(float)cellHeight
{
    return self.lblMessage.frame.size.height + self.atArea.frame.size.height + self.scrollView.frame.size.height + 40;
}

+(float)cellHeightWithMessage:(DAMessage *)message
{
    float height = 0;
    float offset = 8;
    float maxWidth = 320 - offset*2;
    
    DAMessageLabel *label = [[DAMessageLabel alloc] initWithContent:message.content font:[UIFont systemFontOfSize:16] breakMode:NSLineBreakByCharWrapping maxFrame:CGRectMake(offset, height, maxWidth, 5000.0f)];
    height += label.frame.size.height;
    
    DAMessageAtView *view = [[DAMessageAtView alloc] initWithMessage:message frame:CGRectMake(offset, height, maxWidth, 5000)];
    height += view.frame.size.height;
    
    if ([message_contenttype_document isEqualToString:message.contentType] || [message_contenttype_file isEqualToString:message.contentType]) {
        DAMessageFileView *fview = [[DAMessageFileView alloc] initWithMessage:message frame:CGRectMake(20, height, maxWidth - 40, 0)];
        height += fview.frame.size.height;
    }
    
    if ([message_contenttype_image isEqualToString:message.contentType]) {
        height += 165;
    }
    
    // bottom
    height += 40;
    
    return height;
}
@end
