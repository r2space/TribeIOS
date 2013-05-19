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
    [self fetch];
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
    
    [[DAFileModule alloc] getFileList:start count:count callback:^(NSError *error, DAFileList *files){
        [self finishFetch:files.items error:error];
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
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    DAFile *file = [list objectAtIndex:indexPath.row];
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
    detailViewController.getfile = [list objectAtIndex:indexPath.row];
    //detailViewController.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
//    NSLog(@"FileDetailViewController");
//    DAFileWebViewController *detailView = [[DAFileWebViewController alloc] initWithNibName:@"DAFileWebViewController" bundle:nil];
//    DAFile *file = [list objectAtIndex:indexPath.row];
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
