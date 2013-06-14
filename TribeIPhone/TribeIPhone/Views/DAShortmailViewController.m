//
//  DAShortmailViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAShortmailViewController.h"
#import "DAShortmailViewCell.h"
#import "DAShortmailStoryViewController.h"
@interface DAShortmailViewController ()
{
    NSArray *theContacts;
}
@end

@implementation DAShortmailViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [[DAShortmailModule alloc] getUsers:0 count:20 callback:^(NSError *error, DAContactList *contact){
        theContacts = contact.items;
        [self.tblUsers reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return theContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAContact *contact = [theContacts objectAtIndex:indexPath.row];
	DAShortmailViewCell *cell = [DAShortmailViewCell initWithMessage:contact tableView:tableView];
    
    cell.lblName.text = contact.user.name.name_zh;
    
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 61;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DAShortmailStoryViewController *shortmailStoryViewController =[[DAShortmailStoryViewController alloc]initWithNibName:@"DAShortmailStoryViewController" bundle:nil];
    shortmailStoryViewController.hidesBottomBarWhenPushed = YES;
    
    DAContact *contact = ((DAContact *)[theContacts objectAtIndex:indexPath.row]);
    shortmailStoryViewController.contact = contact._id;
    shortmailStoryViewController.uid = contact.user._id;
    
    [self.navigationController pushViewController:shortmailStoryViewController animated:YES];
    
}


- (IBAction)onAddTouched:(id)sender {
    DAShortmailStoryViewController *shortmailStoryViewController =[[DAShortmailStoryViewController alloc]initWithNibName:@"DAShortmailStoryViewController" bundle:nil];
    shortmailStoryViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:shortmailStoryViewController animated:YES];
}
@end
