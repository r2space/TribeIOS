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
    
    [self fetch];
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

- (void)fetch
{
    if ([self preFetch]) {
        return;
    }
    
    [[DAUserModule alloc] getUserListStart:start count:count callback:^(NSError *error, DAUserList *users){
        [self finishFetch:users.items error:error];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAUser *user = [list objectAtIndex:indexPath.row];
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
    memberDetailViewController.uid = ((DAUser *)[list objectAtIndex:indexPath.row])._id ;
    
    [self.navigationController pushViewController:memberDetailViewController animated:YES];
//    [((UINavigationController *)[self parentViewController]) pushViewController:memberDetailViewController animated:YES];
    
}


@end
