//
//  DAMessageDetailViewController.m
//  TribeIPhone
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMessageDetailViewController.h"
#import "DAPictureViewController.h"
#import "DAMemberDetailViewController.h"
#import "DAGroupDetailViewController.h"
#import "DAFileWebViewController.h"

@interface DAMessageDetailViewController ()

@end

@implementation DAMessageDetailViewController
{
    DAMessage* _message;
    int _commentsTotal;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refresh];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }
    if(section == 1 && list != nil){
        return list.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *containerView = [[UIView alloc] init];
        [containerView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *comment = [[UILabel alloc] initWithFrame:CGRectZero];
        comment.backgroundColor = [UIColor clearColor];
        comment.textColor = [UIColor grayColor];
        comment.font = [UIFont systemFontOfSize:12];
        comment.frame = CGRectMake(8, 15, 260, 20);
        
        NSMutableString *str = [NSMutableString stringWithFormat: @"评论：%d",_commentsTotal];
        [str appendString:@"  "];
        
        [str appendString:[NSString stringWithFormat:@"转发：%@", _message.part.forwardNums==nil ? @"0" : _message.part.forwardNums ]];
            
        
        [str appendString:@"  "];
        [str appendString:[NSString stringWithFormat:@"赞：%d", _message.likers.count]];
        comment.text =  str;
        
        [containerView addSubview:comment];
        
        UIImageView *imgSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(1, 48, 320, 2)];
        UIImage *img = [UIImage imageNamed:@"list_line.png"];
        imgSeparator.image = img;
        [containerView addSubview:imgSeparator];
        return containerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"DAMemberCell";
            DAMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
                NSArray *array = [nib instantiateWithOwner:nil options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.imgPortrait.image = [[_message getCreatUser] getUserPhotoImage];
            cell.lblName.text = [[_message getCreatUser] getUserName];
            cell.lblGroup.text = [_message getCreatUser].department.name.name_zh;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            DAMessageDetailCell *cell = [DAMessageDetailCell initWithMessage:_message tableView:tableView];
            cell.rangeTouchedBlocked = ^(NSString *groupId){
                DAGroupDetailViewController *groupDetailViewController =[[DAGroupDetailViewController alloc]initWithNibName:@"DAGroupDetailViewController" bundle:nil];
                groupDetailViewController.hidesBottomBarWhenPushed = YES;
                groupDetailViewController.gid = groupId;
                [self.navigationController pushViewController:groupDetailViewController animated:YES];
            };
            cell.atTouchedBlocks = ^(int type, NSString *objId){
                if (type == 1) {
                    DAMemberDetailViewController *memberDetailViewController = [[DAMemberDetailViewController alloc] initWithNibName:@"DAMemberDetailViewController" bundle:nil];
                    memberDetailViewController.hidesBottomBarWhenPushed = YES;
                    memberDetailViewController.uid = objId;
                    [self.navigationController pushViewController:memberDetailViewController animated:YES];
                }
                if (type == 2) {
                    DAGroupDetailViewController *groupDetailViewController =[[DAGroupDetailViewController alloc]initWithNibName:@"DAGroupDetailViewController" bundle:nil];
                    groupDetailViewController.hidesBottomBarWhenPushed = YES;
                    groupDetailViewController.gid = objId;
                    [self.navigationController pushViewController:groupDetailViewController animated:YES];
                }
            };
            cell.fileTouchedBlocks = ^(int type, NSString *fileId){
                if (type == 1) {
                    [[DAFileModule alloc] getFileDetail:fileId callback:^(NSError *error, DAFileDetail *detail) {
                        if (error == nil) {
                            DAFileWebViewController *detailView = [[DAFileWebViewController alloc] initWithNibName:@"DAFileWebViewController" bundle:nil];
                            DAFile *file = detail.file;
                            detailView.fileDb = file;
                            detailView.downloadId = file.downloadId;
                            detailView.fileExt = file.extension;
                            detailView.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:detailView animated:YES];
                        }
                    }];
                }
            };
            
            if ([message_contenttype_image isEqualToString:_message.contentType]) {
                if (_message.attach.count > 0) {
                    NSMutableArray *ids = [[NSMutableArray alloc] init];
                    for (MessageAttach *file in _message.attach) {
                        [ids addObject:file.fileid];
                    }
                    cell.scrollView.pictureTouchedBlocks = ^(int idx){
                        DAPictureViewController *pictureCtrl = [[DAPictureViewController alloc] initWithNibName:@"DAPictureViewController" bundle:nil];
                        pictureCtrl.PictureIds = ids;
                        pictureCtrl.currIndex = idx;
                        [self presentViewController:pictureCtrl animated:YES completion:nil];
                        
                    };
                }
            }
            return cell;
        }
    } else {
        DAMessage *comment = [list objectAtIndex:indexPath.row];
        return [DACommentCell initWithComment:comment tableView:tableView];
    }
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 55;
        }
        if (indexPath.row == 1) {
            return [DAMessageDetailCell cellHeightWithMessage:_message];
        }
    }
    if (indexPath.section == 1) {
        DAMessage *comment = [list objectAtIndex:indexPath.row];
        return [DACommentCell cellHeightWithComment:comment];
    }
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        DAMemberDetailViewController *memberDetailViewController =[[DAMemberDetailViewController alloc]initWithNibName:@"DAMemberDetailViewController" bundle:nil];
        memberDetailViewController.hidesBottomBarWhenPushed = YES;
        memberDetailViewController.uid = [[_message getCreatUser] _id];
        [self.navigationController pushViewController:memberDetailViewController animated:YES];
    }
}

-(void)fetch
{
    if ([self preFetch]) {
        return;
    }
    
    [[DAMessageModule alloc] getMessage:_messageId callback:^(NSError *error, DAMessage *message) {
        _message = message;
        [self setLike];
        [[DAMessageModule alloc] getComments:_messageId start:start count:count callback:^(NSError *error, DAMessageList *commentList){
            _commentsTotal = commentList.total.intValue;
            [self finishFetch:commentList.items error:error];
        }];
    }];

}

- (IBAction)onCancelTouched:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnHomeTouched:(id)sender {
    UITabBarController *controller = self.tabBarController;
    controller.selectedViewController = [controller.viewControllers objectAtIndex: 0];
}

- (void) setLike
{
    if ([_message.likers containsObject:[DALoginModule getLoginUserId]]) {
        [self.tabBar setSelectedItem:self.barLike];
//        self.barLike.image = [UIImage  imageNamed:@"thumb-up-mini.png"];
    } else {
        [self.tabBar setSelectedItem:nil];
//        self.barLike.image = [UIImage  imageNamed:@"thumb-up-white.png"];
    }
}

#pragma mark - UITabBarDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    if (1 == item.tag) {
        // refresh
        [self refresh];
    }
    
    if (2 == item.tag) {
        // comment
        DAContributeViewController *ctrl = [[DAContributeViewController alloc] initWithNibName:@"DAContributeViewController" bundle:nil];
        ctrl.message.type = [NSNumber numberWithInt:2];
        ctrl.message.range = _message.range;
        ctrl.message.target = _message._id;
        
        [self presentViewController:ctrl animated:YES completion:nil];
    }
    
    if (3 == item.tag) {
        // forward
        DAContributeViewController *ctrl = [[DAContributeViewController alloc] initWithNibName:@"DAContributeViewController" bundle:nil];
        ctrl.message.target = _message._id;
        ctrl.isForward = YES;
        
        [self presentViewController:ctrl animated:YES completion:nil];
    }
    if (4 == item.tag) {
        

        // like
        if ([self preUpdate]) {
            return;
        }
        if ([_message.likers containsObject:[DALoginModule getLoginUserId]]) {
            [[DAMessageModule alloc] unlike:_messageId callback:^(NSError *error, DAMessage *message) {
                if (error != nil) {
                    [self showMessage:[self errorMessage] detail:[NSString stringWithFormat:@"error : %d", [error code]]];
                    return ;
                }
                _message = message;
                [self setLike];
            }];
        } else {
            [[DAMessageModule alloc] like:_messageId callback:^(NSError *error, DAMessage *message) {
                if (error != nil) {
                    [self showMessage:[self errorMessage] detail:[NSString stringWithFormat:@"error : %d", [error code]]];
                    return ;
                }
                _message = message;
                [self setLike];
            }];
        }
    }
    [self setLike];
}

@end
