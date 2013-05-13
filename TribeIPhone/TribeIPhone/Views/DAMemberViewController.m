//
//  DAFriendViewController.m
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DAMemberViewController.h"
#import "DAMemberViewCell.h"
#import "DAMemberDetailViewController.h"

@interface DAMemberViewController ()
{
    NSArray* users;
}
@end

@implementation DAMemberViewController

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
	// Do any additional setup after loading the view.
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [DAUserListFetcher getUserListStart:0 count:20 withDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAUser *user = [users objectAtIndex:indexPath.row];
	DAMemberViewCell *cell = [DAMemberViewCell initWithMessage:user tableView:tableView];

    [cell lblName].text = [user getUserName];
    cell.uid = user._id;
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    NSArray *indexTitleArray;
    
    NSString *a = @"あ/か/さ/た/な/は/ま/や/ら/わ/A/●/D/●/G/●/J/●/M/●/P/●/T/●/Z";
    return [a pathComponents];
//    indexTitleArray = [NSArray arrayWithObjects:@"A", @"B", @"C", nil];
//    return indexTitleArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DAMemberDetailViewController *memberDetailViewController =[[DAMemberDetailViewController alloc]initWithNibName:@"DAMemberDetailViewController" bundle:nil];
    memberDetailViewController.hidesBottomBarWhenPushed = YES;
    memberDetailViewController.uid = ((DAUser *)[users objectAtIndex:indexPath.row])._id ;
    
    [self.navigationController pushViewController:memberDetailViewController animated:YES];
//    [((UINavigationController *)[self parentViewController]) pushViewController:memberDetailViewController animated:YES];
    
}


#pragma mark - DaUserListFetcherDelegate
-(void) didFinishFetchingUserList:(DAUserList *)userList
{
    users = userList.items;
    [self.tableView reloadData];
}

@end
