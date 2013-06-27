//
//  DAMemberMoreContainerViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMemberMoreContainerViewController.h"
#import "DAMemberMoreViewController.h"
#import "DAHelper.h"

@interface DAMemberMoreContainerViewController ()
{
    DAMemberMoreViewController *moreViewController;
}
@end

@implementation DAMemberMoreContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    // 显示静态TableView
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"DAMemberMoreViewController" bundle:nil];
    moreViewController = [stryBoard instantiateInitialViewController];
    moreViewController.user = self.user;
    moreViewController.view.frame = CGRectMake(0, 44, 320, 548);
    
    // 非本人，禁用保存按钮
    if (![self.userid isEqualToString:[DALoginModule getLoginUserId]]) {
        self.btnSave.enabled = NO;
//        [moreViewController.photoCell removeFromSuperview];

    }
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
    // 更新的照片名称
    NSString *file = [DAHelper documentPath:@"upload.jpg"];
    
    // 如果照片存在，则上传照片，然后更新
    if ([DAHelper isFileExist:file]) {
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:file];
        [[DAFileModule alloc] uploadPicture:UIImageJPEGRepresentation(image, 1.0) fileName:file mimeType:@"image/jpg" callback:^(NSError *error, DAFile *file){

            [self update:file._id];
        } progress:nil];
    } else {
        
        // 更新
        [self update:nil];
    }
}

// 更新用户信息
- (void) update:(NSString *)photoId
{
    self.user.name.name_zh = moreViewController.txtName.text;
    
    // 手机号
    if (self.user.tel == nil) {
        self.user.tel = [[UserTel alloc] init];
    }
    self.user.tel.mobile = moreViewController.txtMobile.text;
    
    // 头像
    if (photoId != nil) {
        if (self.user.photo == nil) {
            self.user.photo = [[UserPhoto alloc] init];
        }
        self.user.photo.fid = photoId;
        self.user.photo.x = @"0";
        self.user.photo.y = @"0";
        self.user.photo.width = @"320";
    }
    
    // 描述
    if (self.user.custom == nil) {
        self.user.custom = [[UserCustom alloc] init];
    }
    self.user.custom.memo = moreViewController.txtDescription.text;
    
    // 语言
    switch (moreViewController.segLang.selectedSegmentIndex) {
        case 0:
            self.user.lang = UserLanguageZH;
            break;
        case 1:
            self.user.lang = UserLanguageJP;
            break;
        case 2:
            self.user.lang = UserLanguageEN;
            break;
        default:
            break;
    }
    
    // 住址
    if (self.user.address == nil) {
        self.user.address = [[UserAddress alloc] init];
    }
    self.user.address.city = moreViewController.txtAddress.text;
    
    
    [[DAUserModule alloc] update:self.user callback:^(NSError *error, DAUser *user){
        [DAHelper alert:self.view message:@"更新成功" detail:nil];
    }];
}

@end
