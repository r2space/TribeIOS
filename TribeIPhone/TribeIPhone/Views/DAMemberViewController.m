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
#import "DAMemberFilterViewController.h"

@interface DAMemberViewController ()
{
    MBProgressHUD *_hud;
    NSString *_type;
    NSString *_filterId;
    NSString *_filterTitle;
    NSDictionary *_typeValues;
    NSString *loginuid ;
    
}
@end

@implementation DAMemberViewController
@synthesize listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive;

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
    _type = @"all";
    _filterId = @"all";
    loginuid = [DALoginModule getLoginUserId];
    _typeValues = @{@"all":@"全部",@"follower":@"粉丝",@"following":@"关注",@"group":@"参加的组"};
    [self fetch];
}
-(void)displayFilter
{
    if ([_type isEqualToString:@"all"]) {
        [self.barFilter setTitle:[_typeValues objectForKey:_filterId]];
        [self.barFilterIco setImage:[UIImage imageNamed:@"gateway_binoculars.png"]];
    
    } else if ([_type isEqualToString:@"user"])
    {
        [self.barFilter setTitle:[_typeValues objectForKey:_filterId]];
        [self.barFilterIco setImage:[UIImage imageNamed:@"gateway_cross.png"]];
    }
    else if ([_type isEqualToString:@"group"])
    {
        [self.barFilter setTitle:_filterTitle];
        [self.barFilterIco setImage:[UIImage imageNamed:@"gateway_cross.png"]];
    } else {
        [self.barFilterIco setImage:[UIImage imageNamed:@"gateway_cross.png"]];
    }
    
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
    if ([self preFetch])
    {
        return;
    }
    if ([_type isEqualToString:@"user"])
    {
        if ([_filterId isEqualToString:@"following"])
        {
            [[DAUserModule alloc] getUserFollowingListByUser:loginuid start:start count:count callback:^(NSError *error, DAUserList *users){
                [self displayFilter];
                [self finishFetch:users.items error:error];
                self.filteredListContent = [NSMutableArray arrayWithCapacity:[users.items count]];
            
            // restore search settings if they were saved in didReceiveMemoryWarning.
                if (self.savedSearchTerm)
                {
                    [self.searchDisplayController setActive:self.searchWasActive];
                    [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
                    [self.searchDisplayController.searchBar setText:savedSearchTerm];
                
                    self.savedSearchTerm = nil;
                }
            }];
        } else if ([_filterId isEqualToString:@"follower"]){
            [[DAUserModule alloc] getUserFollowerListByUser:loginuid start:start count:count callback:^(NSError *error, DAUserList *users){
                [self displayFilter];
                [self finishFetch:users.items error:error];
                self.filteredListContent = [NSMutableArray arrayWithCapacity:[users.items count]];
            
            // restore search settings if they were saved in didReceiveMemoryWarning.
                if (self.savedSearchTerm)
                {
                    [self.searchDisplayController setActive:self.searchWasActive];
                    [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:    self.savedScopeButtonIndex];
                    [self.searchDisplayController.searchBar setText:savedSearchTerm];
                
                    self.savedSearchTerm = nil;
                }
            }];
        }
            
    }
    else if ([_type isEqualToString:@"group"])
    {
        [[DAGroupModule alloc] getUserListInGroup:_filterId start:0 count:20 callback:^(NSError *error, DAUserList *users){
            [self displayFilter];
            [self finishFetch:users.items error:error];
            self.filteredListContent = [NSMutableArray arrayWithCapacity:[users.items count]];
            
            // restore search settings if they were saved in didReceiveMemoryWarning.
            if (self.savedSearchTerm)
            {
                [self.searchDisplayController setActive:self.searchWasActive];
                [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
                [self.searchDisplayController.searchBar setText:savedSearchTerm];
                
                self.savedSearchTerm = nil;
            }

        }];
    } else {
        
        [[DAUserModule alloc] getUserListStart:start count:count keywords:@"" callback:^(NSError *error, DAUserList *users){
            [self displayFilter];
            _filterId = @"group";
            [self finishFetch:users.items error:error];
            self.filteredListContent = [NSMutableArray arrayWithCapacity:[users.items count]];
            
            // restore search settings if they were saved in didReceiveMemoryWarning.
            if (self.savedSearchTerm)
            {
                [self.searchDisplayController setActive:self.searchWasActive];
                [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
                [self.searchDisplayController.searchBar setText:savedSearchTerm];
                
                self.savedSearchTerm = nil;
            }
        }];

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredListContent count];
    }else
	{
        return [list count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAUser *user = [list objectAtIndex:indexPath.row];
	DAMemberViewCell *cell = [DAMemberViewCell initWithMessage:user tableView:tableView];
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        user = [self.filteredListContent objectAtIndex:indexPath.row];
    }else
	{
        user = [list objectAtIndex:indexPath.row];
    }
    [cell lblName].text = [user getUserName];
    cell.uid = user._id;
    cell.lblDepart.text = user.department.name.name_zh;
    cell.lblDescription.text = user.custom.memo;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
////    NSArray *indexTitleArray;
//
//    NSString *a = @"あ/か/さ/た/な/は/ま/や/ら/わ/A/●/D/●/G/●/J/●/M/●/P/●/T/●/Z";
//    return [a pathComponents];
////    indexTitleArray = [NSArray arrayWithObjects:@"A", @"B", @"C", nil];
////    return indexTitleArray;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DAMemberDetailViewController *memberDetailViewController =[[DAMemberDetailViewController alloc]initWithNibName:@"DAMemberDetailViewController" bundle:nil];
    memberDetailViewController.hidesBottomBarWhenPushed = YES;
    memberDetailViewController.uid = ((DAUser *)[list objectAtIndex:indexPath.row])._id ;
    
    [self.navigationController pushViewController:memberDetailViewController animated:YES];
    //    [((UINavigationController *)[self parentViewController]) pushViewController:memberDetailViewController animated:YES];
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (DAUser *user in list)
	{
		
        NSComparisonResult result = [user.name.name_zh compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [self.filteredListContent addObject:user];
        }
		
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
- (IBAction)barFilterOnClick:(id)sender {
    DAMemberFilterViewController *filterCtrl = [[DAMemberFilterViewController alloc] initWithNibName:@"DAMemberFilterViewController" bundle:nil];
    [filterCtrl setTitle:@"筛选"];
    filterCtrl.selectedBlocks = ^(NSString *filter,NSString *type,NSString *title){
        _type = type;
        _filterId = filter;
        _filterTitle = title;
        [self refresh];
        [DAHelper hidePopup];
    };
    [DAHelper showPopup:filterCtrl];
}

- (IBAction)barFilterIcoOnClick:(id)sender {
    if ([_type isEqualToString:@"all"]) {
        [self barFilterOnClick:nil];
    } else {
        _type = @"all";
        _filterId = @"all";
        [self refresh];
    }
}



@end
