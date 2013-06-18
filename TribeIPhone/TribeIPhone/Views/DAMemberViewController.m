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
    
    NSString *_keywords;
    
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
    _type = @"all";
    _filterId = @"all";
    loginuid = [DALoginModule getLoginUserId];
    _keywords =@"";
    _typeValues = @{@"all":@"全部",@"follower":@"粉丝",@"following":@"关注",@"group":@"参加的组"};
    [self fetch];
    _searchBar.placeholder = @"检索名称、拼音、邮箱";
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
            [[DAUserModule alloc] getUserFollowingListByUser:loginuid start:start count:count keywords:_keywords callback:^(NSError *error, DAUserList *users){
                [self displayFilter];
                [self finishFetch:users.items error:error];
            }];
        } else if ([_filterId isEqualToString:@"follower"]){
            [[DAUserModule alloc] getUserFollowerListByUser:loginuid start:start count:count keywords:_keywords callback:^(NSError *error, DAUserList *users){
                [self displayFilter];
                [self finishFetch:users.items error:error];
            }];
        }
            
    }
    else if ([_type isEqualToString:@"group"])
    {
        [[DAUserModule alloc] getUserListInGroup:_filterId uid:loginuid start:start count:count keywords:_keywords callback:^(NSError *error, DAUserList *users){
            [self displayFilter];
            [self finishFetch:users.items error:error];
        }];
    } else {
        
        [[DAUserModule alloc] getUserListStart:start count:count keywords:_keywords callback:^(NSError *error, DAUserList *users){
            [self displayFilter];
            [self finishFetch:users.items error:error];
        }];

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAUser *user = [list objectAtIndex:indexPath.row];
	DAMemberViewCell *cell = [DAMemberViewCell initWithMessage:user tableView:tableView];
 
    user = [list objectAtIndex:indexPath.row];
  
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




#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (IBAction)barFilterOnClick:(id)sender {
    DAMemberFilterViewController *filterCtrl = [[DAMemberFilterViewController alloc] initWithNibName:@"DAMemberFilterViewController" bundle:nil];
    [filterCtrl setTitle:@"筛选"];
    filterCtrl.selectedBlocks = ^(NSString *filter,NSString *type,NSString *title){
        _type = type;
        _filterId = filter;
        _filterTitle = title;
        _keywords = @"";
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

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.view endEditing:YES];
    _keywords = searchBar.text;
    [self refresh];
    _searchBar.text = @"";
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    _keywords = @"";
//    _type = @"all";
//    _filterId = @"all";
    [self refresh];
}


@end
