//
//  DAFileDetailViewController.m
//  TribeIPhone
//
//  Created by mac on 13-5-6.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAFileDetailViewController.h"
#import "DAFileWebViewController.h"
#import "DAHelper.h"
#import "DAFileViewCell.h"
#import "WTStatusBar.h"
#import "MBProgressHUD.h"

@interface DAFileDetailViewController ()
{
    DAFileDetail *filedb;
    NSArray *theFileList;
    MBProgressHUD *_hud;
}
@end

@implementation DAFileDetailViewController
@synthesize getfile;


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
    // 初始化HUD
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Loging...";
    _hud.color = DAColor;
    
    [[DAFileModule alloc] getFileDetail:getfile._id callback:^(NSError *error, DAFileDetail *file){
        filedb = file;
        self.lblFileName.text = getfile.filename;
        self.lblAt.text = filedb.user.name.name_zh;
        self.imgFileType.image = [UIImage imageNamed:[DAHelper fileanExtension:filedb.file.contentType]];
        
    }];
    [[DAFileModule alloc] getFileHistory:getfile._id callback:^(NSError *error, DAFileHistory *histroy) {
        theFileList = histroy.items;
        [self.tableView reloadData];
        
        [_hud hide:YES];
    }];
    
    
}
- (IBAction)onCancelTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    return theFileList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DAFile *file = [theFileList objectAtIndex:indexPath.row];
	DAFileViewCell *cell = [DAFileViewCell initWithMessage:file tableView:tableView];
    
    cell.lblFileName.text = file.filename;
    cell.lblAt.text = file.uploadDate;
    cell.imgFileType.image = [UIImage imageNamed:[DAHelper fileanExtension:file.contentType]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"FileDetailViewController");
    DAFileWebViewController *detailView = [[DAFileWebViewController alloc] initWithNibName:@"DAFileWebViewController" bundle:nil];
    DAFile *file = [theFileList objectAtIndex:indexPath.row];
    
    detailView.fileUrl = file._id;//[NSString stringWithFormat:@"%@file/download.json?_id=%@", kRemote,file._id];
    detailView.fileName = file.filename;
    detailView.downloadId = file._id;
    detailView.fileExt = file.extension;
    detailView.fileDb = file;
    
    
    
    [self.navigationController pushViewController:detailView animated:YES];
    
    
}




@end
