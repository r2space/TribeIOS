//
//  DAGroupViewController.m
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DAGroupViewController.h"
#import "DAGroupViewCell.h"
#import "DAGroupDetailViewController.h"
#import "DAGroupMoreContainerViewController.h"

@interface DAGroupViewController ()
{
    NSArray* theGroups;
}
@end

@implementation DAGroupViewController

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
    
    // 不显示空行的cell分隔线
    self.tblGroups.tableFooterView = [[UIView alloc]init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[DAGroupModule alloc] getGroupListStart:0 count:20 callback:^(NSError *error, DAGroupList *groups){
        theGroups = groups.items;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return theGroups.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAGroup *group = [theGroups objectAtIndex:indexPath.row];
	DAGroupViewCell *cell = [DAGroupViewCell initWithMessage:group  tableView:tableView];
    
    [cell lblName].text = group.name.name_zh;
    cell.gid = group._id;
    cell.lblDescription.text = group.description;
    cell.lblMembers.text = [NSString stringWithFormat:@"%d 成员",group.member.count];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DAGroupDetailViewController *groupDetailViewController =[[DAGroupDetailViewController alloc]initWithNibName:@"DAGroupDetailViewController" bundle:nil];
    groupDetailViewController.hidesBottomBarWhenPushed = YES;
    groupDetailViewController.gid = ((DAGroup *)[theGroups objectAtIndex:indexPath.row])._id ;
    
    [self.navigationController pushViewController:groupDetailViewController animated:YES];
    
}


//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSString *a = @"あ/か/さ/た/な/は/ま/や/ら/わ/A/●/D/●/G/●/J/●/M/●/P/●/T/●/Z";
//    return [a pathComponents];
//}

- (IBAction)onAddTouched:(id)sender {
    DAGroupMoreContainerViewController *moreViewController = [[DAGroupMoreContainerViewController alloc] initWithNibName:@"DAGroupMoreContainerViewController" bundle:nil];
    [self.navigationController pushViewController:moreViewController animated:YES];
}

@end
