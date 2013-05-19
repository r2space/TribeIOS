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
    NSArray* theUsers;
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
    
    [self refresh];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    if ([self startFetch]) {
        return;
    }
    
    [[DAUserModule alloc] getUserListStart:0 count:20 callback:^(NSError *error, DAUserList *users){
        if (error == nil) {
            theUsers = users.items;
            [self.tableView reloadData];
        }
        
        [self finishFetch:error];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return theUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAUser *user = [theUsers objectAtIndex:indexPath.row];
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
    memberDetailViewController.uid = ((DAUser *)[theUsers objectAtIndex:indexPath.row])._id ;
    
    [self.navigationController pushViewController:memberDetailViewController animated:YES];
//    [((UINavigationController *)[self parentViewController]) pushViewController:memberDetailViewController animated:YES];
    
}


@end
