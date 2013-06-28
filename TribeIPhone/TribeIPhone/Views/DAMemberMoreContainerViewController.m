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
#import "DAMemberMoreDetailCell.h"
#import "DAGroupController.h"
#import "DAMemberController.h"

@interface DAMemberMoreContainerViewController ()
{
    
    
    BOOL isPhotoChanged;
    BOOL isMine;
    float viewHeight;
    
}
@end

@implementation DAMemberMoreContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isMine = YES;
    
    isPhotoChanged = NO;
    // 非本人，禁用保存按钮
    if (![self.userid isEqualToString:[DALoginModule getLoginUserId]]) {
        self.btnSave.enabled = NO;
        [self.btnSave setImage:nil];
        isMine = NO;
        
    }else{
//        self.userid = [DALoginModule getLoginUserId];
    }
    [[DAUserModule alloc]getUserById:self.userid callback:^(NSError *error, DAUser *userdb){
        self.user = userdb;
        [self.tableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// 返回
- (IBAction)onCancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    viewHeight = self.view.frame.size.height;
}
// 保存
- (IBAction)onSaveTouched:(id)sender
{
    // 更新的照片名称
    NSString *file = [DAHelper documentPath:@"upload.jpg"];
    
    
    
    // 如果照片存在，则上传照片，然后更新
    if (isPhotoChanged&&[DAHelper isFileExist:file]) {
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:file];
        [[DAFileModule alloc] uploadPicture:UIImageJPEGRepresentation(image, 1.0) fileName:file mimeType:@"image/jpg" callback:^(NSError *error, DAFile *file){

            [self update:file._id];
            isPhotoChanged = NO;
        } progress:nil];
    } else {
        
        // 更新
        [self update:nil];
    }
}

// 更新用户信息
- (void) update:(NSString *)photoId
{
    
    if (photoId) {
        UserPhoto * photo = [[UserPhoto alloc] init];
        photo.fid = photoId;
        photo.x = @"0";
        photo.y = @"0";
        photo.width = @"320";
        self.user.photo = photo;
    }
    
    [[DAUserModule alloc] update:self.user callback:^(NSError *error, DAUser *user){
        [DAHelper alert:self.view message:@"更新成功" detail:nil];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (isMine) {
        if (0==section) {
            return 3;
        }else{
            return 6;
        }
    }else{
        if (0==section) {
            return 3;
        }else{
            return 5;
        }
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"DAMemberMoreDetailCell";

    DAMemberMoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    if (indexPath.section ==0 ) {
        switch (indexPath.row) {
            case 0:
                [self rendCell:cell title:@"参加的组" icon: @"table_business-team.png" value:@"0" tag:10 hasDetail:YES];
                
                break;
            case 1:
                [self rendCell:cell title:@"关注的人" icon: @"business-man.png" value:@"0" tag:10 hasDetail:YES];
                
                
                break;
            case 2:
                [self rendCell:cell title:@"粉丝" icon: @"business-man.png" value:@"0" tag:10 hasDetail:YES];
                
                break;
            default:
                break;
        }
    }else{
        if (isMine) {
            switch (indexPath.row) {
                case 0:
                    [self rendCell:cell title:@"姓名" icon: @"price-tag.png" value:self.user.name.name_zh tag:0 hasDetail:NO];
                    cell.tag = 0;
                    break;
                case 1:
                    
                    [self rendCell:cell title:@"头像" icon: @"table_photo.png" value:self.user.tel.mobile tag:1  hasDetail:YES];
                    break;
                case 2:
                    
                    [self rendCell:cell title:@"手机" icon: @"table_phone.png" value:self.user.tel.mobile tag:2 hasDetail:NO];
                    cell.tag = 1;
                    cell.txtValue.keyboardType = UIKeyboardTypeNumberPad;
                    break;
                case 3:
                    
                    [self rendCell:cell title:@"邮件" icon: @"tab_email.png" value:self.user.uid tag:3 hasDetail:NO];
                    cell.tag = 2;
                    break;
                case 4:
                    
                    [self rendCell:cell title:@"住址" icon: @"table_rural-house.png" value:self.user.address!=nil?self.user.address.city:@"" tag:4 hasDetail:NO];
                    cell.tag = 3;
                    break;
                case 5:
                    
                    [self rendCell:cell title:@"简介" icon: @"table_document-scroll.png" value:self.user.custom != nil?self.user.custom.memo:@"" tag:5 hasDetail:NO];
                    cell.tag = 4;
                    
                    break;
                default:
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 0:
                    [self rendCell:cell title:@"姓名" icon: @"price-tag.png" value:self.user.name.name_zh tag:0 hasDetail:NO];
                    
                    break;
                case 1:
                    [self rendCell:cell title:@"手机" icon: @"table_phone.png" value:self.user.tel.mobile tag:1 hasDetail:NO];
                    break;
                case 2:
                    [self rendCell:cell title:@"邮件" icon: @"tab_email.png" value:self.user.uid tag:2 hasDetail:NO];
                    break;
                case 3:
                    
                    [self rendCell:cell title:@"住址" icon: @"table_rural-house.png" value:self.user.address!=nil?self.user.address.city:@"" tag:3  hasDetail:NO];
                    break;
                case 4:
                    
                    [self rendCell:cell title:@"简介" icon: @"table_document-scroll.png" value:self.user.custom != nil?self.user.custom.memo:@"" tag:4 hasDetail:NO];
                    break;
                default:
                    break;
            }
        }
        
    }
    
    return cell;
    
}
- (IBAction)didEndOnExit:(id)sender
{
    [((UITextField *)sender) resignFirstResponder];
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 44;
    }
    
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0){
        if (indexPath.row == 0 ) {
            DAGroupController *groupController = [[DAGroupController alloc] initWithNibName:@"DAGroupController" bundle:nil];
            
            groupController.uid = self.userid;
            [self.navigationController pushViewController:groupController animated:YES];
        }else if(indexPath.row == 1){
            // 关注的人
            DAMemberController *members = [[DAMemberController alloc] initWithNibName:@"DAMemberController" bundle:nil];
            members.uid = self.userid;
            members.kind = DAMemberListFollowing;
            
            members.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:members animated:YES];
        }else {
            // 粉丝
            DAMemberController *members = [[DAMemberController alloc] initWithNibName:@"DAMemberController" bundle:nil];
            members.uid = self.userid;
            members.kind = DAMemberListFollower;
            
            members.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:members animated:YES];
            
        }
    }else{
        if (indexPath.row == 0 ) {
            
        }else if(indexPath.row == 1&&isMine){
            
            // 判断相机是否可用（模拟器）
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                return;
            }
            
            // UIImagePickerControllerのインスタンスを生成
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            // デリゲートを設定
            imagePickerController.delegate = self;
            
            // 画像の取得先をカメラに設定
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            // 画像取得後に編集するかどうか（デフォルトはNO）
            imagePickerController.allowsEditing = YES;
            
            // 撮影画面をモーダルビューとして表示する
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }else if(indexPath.row == 2){
            
        }else if(indexPath.row == 3){
            
        }else if(indexPath.row == 4){
            
        }else if(indexPath.row == 5){
            
        }
        
    }
}

-(DAMemberMoreDetailCell *)rendCell:(DAMemberMoreDetailCell *)cell title:(NSString *)title icon:(NSString *)icon value:(NSString *)value tag:(int )tag hasDetail:(BOOL)hasDetail
{
    cell.lblName.text = title;
    cell.txtValue.text = value;
    cell.txtValue.delegate = self;
    cell.txtValue.placeholder = title;
    if (!isMine) {
        [cell.txtValue setEnabled:NO];
    }else{
        [cell.txtValue setEnabled:YES];
    }
    if ([title isEqualToString:@"邮件"]) {
        [cell.txtValue setEnabled:NO];
    }
    
    cell.imgPortrait.image = [UIImage imageNamed:icon];
    if (hasDetail) {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.txtValue removeFromSuperview];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
     [cell.txtValue addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [cell.txtValue setTag:tag];
    return cell;
}
- (void) textFieldDidChange:(UITextField *) TextField
{
    if (TextField.tag == 0) {
        self.user.name.name_zh = TextField.text;
        if (TextField.text.length>0) {
            [self.btnSave setEnabled:YES];
        }else{
            [self.btnSave setEnabled:NO];
        }
    } else if(TextField.tag == 2){
        self.user.tel.mobile = TextField.text;
    } else if(TextField.tag == 3){
        self.user.uid = TextField.text;
    } else if(TextField.tag == 4){
        self.user.address.city = TextField.text;
    } else if(TextField.tag == 5){
        self.user.custom.memo = TextField.text;
    }
    
}
// 画像が選択された時に呼ばれるデリゲートメソッド
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[DAHelper documentPath:@"upload.jpg"] atomically:YES];
    isPhotoChanged = YES;
    
    // 渡されてきた画像をフォトアルバムに保存
    // UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:), NULL);
}

// 画像の選択がキャンセルされた時に呼ばれるデリゲートメソッド
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // キャンセルされたときの処理を記述・・・
}
// 收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
// 画像の保存完了時に呼ばれるメソッド
- (void)targetImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)context
{
    if (error) {
        // 保存失敗時の処理
    } else {
        // 保存成功時の処理
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    CGRect r = self.view.frame;
    r.size.height = viewHeight - height;
    
    // 上移View
    self.view.frame = r;

//    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:NO];
//    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewStylePlain animated:YES];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGRect r = self.view.frame;
    r.size.height = viewHeight;
    
    // 下移View
    self.view.frame = r;

}

@end
