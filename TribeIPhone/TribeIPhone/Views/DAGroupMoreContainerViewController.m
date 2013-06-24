//
//  DAGroupMoreContainerViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAGroupMoreContainerViewController.h"
#import "DAGroupMoreViewController.h"
#import "DAHelper.h"

@interface DAGroupMoreContainerViewController ()
{
    DAGroupMoreViewController *moreViewController;
}

@end

@implementation DAGroupMoreContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"DAGroupMoreViewController" bundle:nil];
    moreViewController = [stryBoard instantiateInitialViewController];
    
    moreViewController.group = self.group;
    moreViewController.view.frame = CGRectMake(0, 44, 320, 548);
    [self addChildViewController:moreViewController];
    [self.view addSubview:moreViewController.view];
}

// 返回
- (IBAction)onCancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 保存
- (IBAction)onSaveTouched:(id)sender
{
    NSString *file = [DAHelper documentPath:@"upload.jpg"];
    
    // 更新
    if ([DAHelper isFileExist:file]) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:file];
        [[DAFileModule alloc] uploadFile:UIImageJPEGRepresentation(image, 1.0) fileName:file mimeType:@"image/jpg" callback:^(NSError *error, DAFile *file){
            
            [self updateGroup: file._id];
        } progress:nil];
    } else {
        [self updateGroup: nil];
    }
}

- (void)updateGroup:(NSString *)fileId
{
    // 没有，则创建组
    if (self.group == nil) {
        self.group = [[DAGroup alloc] init];
        self.group.name = [[GroupName alloc] init];
    }
    
    self.group.name.name_zh = moreViewController.txtName.text;
    self.group.description = moreViewController.txtDescription.text;
    self.group.category = moreViewController.txtCategory.text;
    self.group.secure = moreViewController.segSecurity.selectedSegmentIndex == 0 ? GroupSecureTypePublic : GroupSecureTypePrivate;

    // 如果头像存在，指定新照片的切割范围
    if (fileId) {
        GroupPhoto * photo = [[GroupPhoto alloc] init];
        photo.fid = fileId;
        photo.x = @"0";
        photo.y = @"0";
        photo.width = @"320";
        self.group.photo = photo;
    }

    // 更新或新规
    if ([self preUpdate]) {
        return;
    }
    if (self.group._id == nil) {
        [[DAGroupModule alloc] create:self.group callback:^(NSError *error, DAGroup *group) {
            if ([self finishUpdateError:error]) {
                return ;
            }
        }];
    } else {
        [[DAGroupModule alloc] update:self.group callback:^(NSError *error, DAGroup *group) {
            if ([self finishUpdateError:error]) {
                return ;
            }
        }];
    }
}

@end
