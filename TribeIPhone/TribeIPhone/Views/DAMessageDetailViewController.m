//
//  DAMessageDetailViewController.m
//  TribeIPhone
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMessageDetailViewController.h"
#import "DAPictureViewController.h"

@interface DAMessageDetailViewController ()

@end

@implementation DAMessageDetailViewController
@synthesize message;

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
    
    [[DAMessageModule alloc] getComments:self.message._id start:0 count:20 callback:^(NSError *error, DAMessageList *commentList){
        self.commentList = commentList;
        [self.tableView reloadData];
    }];
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
    if(section == 1 && self.commentList != nil){
        return self.commentList.items.count;
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
        comment.textColor = [UIColor blueColor];
        comment.font = [UIFont systemFontOfSize:14];
        comment.frame = CGRectMake(8, 15, 60, 20);
        comment.text =  [NSString stringWithFormat: @"评论：%@",self.commentList.total];
        
        [containerView addSubview:comment];
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
            cell.imgPortrait.image = [[message getCreatUser] getUserPhotoImage];
            cell.lblName.text = [[message getCreatUser] getUserName];
            return cell;
        } else {
            DAMessageDetailCell *cell = [DAMessageDetailCell initWithMessage:message tableView:tableView];
            return cell;
        }
    } else {
        DAMessage *comment = [self.commentList.items objectAtIndex:indexPath.row];
        return [DACommentCell initWithComment:comment tableView:tableView];
    }
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        }
        if (indexPath.row == 1) {
            return [DAMessageDetailCell cellHeightWithMessage:message];
        }
    }
    if (indexPath.section == 1) {
        DAMessage *comment = [self.commentList.items objectAtIndex:indexPath.row];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)onCancelTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnHomeTouched:(id)sender {
    UITabBarController *controller = self.tabBarController;
    controller.selectedViewController = [controller.viewControllers objectAtIndex: 0];
}

#pragma mark - UITabBarDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (1 == item.tag) {
        // refresh
    }
    
    if (2 == item.tag) {
        // comment
        DAContributeViewController *ctrl = [[DAContributeViewController alloc] initWithNibName:@"DAContributeViewController" bundle:nil];
        ctrl.message.type = [NSNumber numberWithInt:2];
        ctrl.message.range = self.message.range;
        ctrl.message.target = self.message._id;
        
        [self presentViewController:ctrl animated:YES completion:nil];
    }
    
    if (3 == item.tag) {
        // forward
        DAContributeViewController *ctrl = [[DAContributeViewController alloc] initWithNibName:@"DAContributeViewController" bundle:nil];
        ctrl.message.target = self.message._id;
        ctrl.isForward = YES;
        
        [self presentViewController:ctrl animated:YES completion:nil];
    }
    if (4 == item.tag) {
        if ([message_contenttype_image isEqualToString:message.contentType]) {
            if (message.attach.count > 0) {
                DAPictureViewController *pictureCtrl = [[DAPictureViewController alloc] initWithNibName:@"DAPictureViewController" bundle:nil];
                NSMutableArray *ids = [[NSMutableArray alloc] init];
                for (MessageAttach *file in message.attach) {
                    [ids addObject:file.fileid];
                }
                pictureCtrl.PictureIds = ids;
                [self presentViewController:pictureCtrl animated:YES completion:nil];
            }
        }
    }
}

@end
