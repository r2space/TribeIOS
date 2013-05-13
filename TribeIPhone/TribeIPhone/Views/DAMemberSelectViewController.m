//
//  DAMemberSelectViewController.m
//  TribeIPhone
//
//  Created by kita on 13-4-25.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMemberSelectViewController.h"

@interface DAMemberSelectViewController ()
{
    NSArray *_allUsers;
    NSMutableArray *_unSelectUsers;
}
@end

@implementation DAMemberSelectViewController

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
    
    _allUsers = [[NSArray alloc] init];
    _unSelectUsers = [[NSMutableArray alloc] init];
    [DAUserListFetcher getUserListStart:0 count:200 withDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.selectedUsers.count;
    }
    return _unSelectUsers.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isSelected = indexPath.section == 0 ? YES : NO;
    DAUser *user;
    if (isSelected) {
        user = [self.selectedUsers objectAtIndex:indexPath.row];
    } else {
        user = [_unSelectUsers objectAtIndex:indexPath.row];
    }
    DAMemberCell *cell = [DAMemberCell initWithMessage:user tableView:tableView];
    cell.lblName.text = [user getUserName];
    cell.accessoryType = isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DAUser *user = [self.selectedUsers objectAtIndex:indexPath.row];
        [self.selectedUsers removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self setUnSelectUsers];
        int idx = [self getIndexInUsers:_unSelectUsers user:user];
        if (idx > 0) {
            NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:idx inSection:1]];
            [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        }
    } else {
        DAUser *user = [_unSelectUsers objectAtIndex:indexPath.row];
        if (self.allowMultiSelect) {
            [self.selectedUsers addObject:user];
            NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.selectedUsers.count-1 inSection:0]];
            [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            [self setUnSelectUsers];
            indexPaths = [NSArray arrayWithObject:indexPath];
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        } else {
            [self.selectedUsers removeAllObjects];
            [self.selectedUsers addObject:user];
            [self setUnSelectUsers];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate didFinshSelectUser];
            }];
            
        }
    }
}

-(void)setUnSelectUsers
{
    [_unSelectUsers removeAllObjects];
    for (DAUser *user in _allUsers) {
        if (![self isUserSelected:user]) {
            [_unSelectUsers addObject:user];
        }
    }
}

-(BOOL)isUserSelected:(DAUser *)user
{
    for (DAUser *u in self.selectedUsers) {
        if ([user._id isEqualToString:u._id]) {
            return YES;
        }
    }
    return NO;
}

-(int) getIndexInUsers:(NSArray *)users user:(DAUser *)user
{
    for (int i = 0; i < users.count; i++) {
        DAUser *u = [users objectAtIndex:i];
        if ([user._id isEqualToString:u._id]) {
            return i;
        }
    }
    return -1;
}

- (IBAction)onCancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSelectClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didFinshSelectUser];
    }];
}

#pragma mark - DAUserListFetcherDelegate
- (void)didFinishFetchingUserList:(DAUserList *)userList
{
    _allUsers = userList.items;
    [self setUnSelectUsers];
    [self.tableView reloadData];
}
@end