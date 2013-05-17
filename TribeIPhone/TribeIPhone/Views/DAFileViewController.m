//
//  DAFileViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/24.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAFileViewController.h"
#import "DAFileViewCell.h"
#import "DAHelper.h"
#import "DAFileDetailViewController.h"
#import "DAFileWebViewController.h"

#import "WTStatusBar.h"

@interface DAFileViewController ()
{
    NSArray *theFileList;
    MBProgressHUD *_hud;
}

@end

@implementation DAFileViewController

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
    
    [self refresh];
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
    
    [[DAFileModule alloc] getFileList:0 count:20 callback:^(NSError *error, DAFileList *files){
        if (error == nil) {
            theFileList = files.items;
            [self.tableView reloadData];
        }
        
        [self finishFetch:error];
    }];
}

- (IBAction)onCancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onAddTouched:(id)sender
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = NO;
    
    [self presentViewController:ipc animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *fromCamera = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *fileName = @"FromIPhoneCamera.jpg";
    NSString *mimeType = @"image/jpeg";
    NSData *uploadFile = UIImageJPEGRepresentation(fromCamera, 1);
    
    // 在状态栏显示进度
    [WTStatusBar setProgressBarColor:DAColor];
    [WTStatusBar setStatusText:@"uploading..." animated:YES];
    
    // HUD
    [_hud show:YES];

    [[DAFileModule alloc] uploadFile:uploadFile fileName:fileName mimeType:mimeType callback:^(NSError *error, DAFile *file){
        [WTStatusBar setStatusText:@"done!" timeout:0.5 animated:YES];
        [_hud hide:YES];
    } progress:^(CGFloat percent){
        [WTStatusBar setProgress:percent animated:YES];
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    DAFileDetailViewController *detailViewController = [[DAFileDetailViewController alloc] initWithNibName:@"DAFileDetailViewController" bundle:nil];
    detailViewController.getfile = [theFileList objectAtIndex:indexPath.row];
    //detailViewController.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
//    NSLog(@"FileDetailViewController");
//    DAFileWebViewController *detailView = [[DAFileWebViewController alloc] initWithNibName:@"DAFileWebViewController" bundle:nil];
//    DAFile *file = [theFileList objectAtIndex:indexPath.row];
//    //kRemote  是接口的网址
//    detailView.fileUrl = [NSString stringWithFormat:@"%@file/download.json?_id=%@", kRemote,file.downloadId];
//    
//    detailView.fileName = file.filename;
//    detailView.downloadId = file.downloadId;
//    detailView.fileExt = file.extension;
//    detailView.fileDb = file;
    
    
    
//    [self.navigationController pushViewController:detailView animated:YES];
    
}
@end
