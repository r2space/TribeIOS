//
//  DAGroupController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//
#import "DAGroupController.h"

@interface DAGroupController ()
{
    NSArray *theGroups;
}

@end

@implementation DAGroupController

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
    
    [[DAGroupListFetcher alloc] getGroupListByUser:self.uid start:0 count:20 delegate:self];
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
    return theGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAGroup *group = [theGroups objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    }
    
    cell.textLabel.text = group.name.name_zh;
    return cell;
}

- (void)didFinishFetchingGroupList:(DAGroupList *)groupList
{
    NSLog(@"%d", groupList.items.count);
    theGroups = groupList.items;
    [self.tblGroupList reloadData];
    
}

- (IBAction)onCancelTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end