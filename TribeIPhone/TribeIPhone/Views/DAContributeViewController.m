//
//  DACreateMessageViewController.m
//  tribe
//
//  Created by 李 林 on 2012/12/04.
//  Copyright (c) 2012年 dac. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "DAContributeViewController.h"
#import "DAFileSelectViewController.h"

@interface DAContributeViewController ()
{
    CLLocationManager *_manager;
    CLGeocoder *_geocoder;
    NSMutableArray *_rangeGroup;
    NSMutableArray *_atGroups;
    NSMutableArray *_atUsers;
    NSMutableArray *_documents;
    BOOL _photoFromCamera;
    NSString *_actionType;
}

@end

@implementation DAContributeViewController
@synthesize message = _message;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _message = [[DAMessage alloc] init];
        _isForward = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    
    [self.txtMessage becomeFirstResponder];
    _geocoder = [[CLGeocoder alloc] init];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    _message = [[DAMessage alloc] init];
    _message.contentType = message_contenttype_text;
    _rangeGroup = [[NSMutableArray alloc] init];
    _atGroups = [[NSMutableArray alloc] init];
    _atUsers = [[NSMutableArray alloc] init];
    if (_documents == nil) {
        _documents = [[NSMutableArray alloc] init];
    }
    
    if ([_message.type isEqualToNumber:[NSNumber numberWithInt:2]]) {
        [self.optionView setHidden:YES];
    }
    
    if (_isForward) {
        [self.btnLocation setHidden:YES];
        [self.btnCamera setHidden:YES];
        [self.imgAttach setHidden:YES];
        [self.btnDocument setHidden:YES];
        [self.btnPhoto setHidden:YES];
    }
    
    self.txtMessage.layer.borderWidth = 1.2;
    self.txtMessage.layer.borderColor = [[UIColor grayColor] CGColor];
    self.txtMessage.layer.cornerRadius = 10;
    
    self.btnClearImg.hidden = YES;
    
    if ([@"shareDocument" isEqualToString:_actionType]) {
        _message.contentType = message_contenttype_document;
        [self.btnPhoto setHidden:YES];
        [self.btnCamera setHidden:YES];
    }
    
    [self renderButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDocuments:(NSArray *)documents
{
    _documents = [[NSMutableArray alloc] initWithArray:documents];
    _actionType = @"shareDocument";
}

-(void)renderButtons
{
    if ([self hasAt]) {
        [self.btnAt setImage:[UIImage imageNamed:@"group_add_highlight.png"] forState:UIControlStateNormal];
    } else {
        [self.btnAt setImage:[UIImage imageNamed:@"group_add.png"] forState:UIControlStateNormal];
    }
    
    
    
    if ([message_contenttype_image isEqualToString:_message.contentType]) {
        if (_photoFromCamera) {
            [self.btnCamera setImage:[UIImage imageNamed:@"camera_highlight.png"] forState:UIControlStateNormal];
            [self.btnPhoto setImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
        } else {
            [self.btnCamera setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
            [self.btnPhoto setImage:[UIImage imageNamed:@"photo_highlight.png"] forState:UIControlStateNormal];
        }
    } else {
        [self.btnCamera setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        [self.btnPhoto setImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
    }
    
    if ([message_contenttype_document isEqualToString:_message.contentType]) {
        [self.btnDocument setImage:[UIImage imageNamed:@"document_highlight.png"] forState:UIControlStateNormal];
    } else {
        [self.btnDocument setImage:[UIImage imageNamed:@"document.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)onLocationClicked:(id)sender
{
    NSLog(@"onLocationClicked");
    
    // プロパティではなくクラスメソッドです
    if ([CLLocationManager locationServicesEnabled]) {
        // インスタンスを生成し、デリゲートの設定
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        
        // 取得精度
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        // 更新頻度（メートル）
        _manager.distanceFilter = kCLDistanceFilterNone;
        // サービスの開始
        [_manager startUpdatingLocation];
    }
    
}

// 標準位置情報サービス・大幅変更位置情報サービスの取得に成功した場合
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    CLLocationDegrees latitude = 37.33233141;
//    CLLocationDegrees longitude = -122.03121860;
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

    
    // 逆ジオコーディングの開始　住所名を取得
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%s | %@", __PRETTY_FUNCTION__, error);
        } else {
            if (0 < [placemarks count]) {
                // ログ出力
                NSLog(@"%s", __PRETTY_FUNCTION__);
                CLPlacemark *placemark = [placemarks objectAtIndex:0];

                NSLog(@"addressDictionary: %@", placemark.addressDictionary);
                NSLog(@"administrativeArea: %@", placemark.administrativeArea);
                NSLog(@"areasOfInterest: %@", placemark.areasOfInterest);
                NSLog(@"country: %@", placemark.country);
                NSLog(@"inlandWater: %@", placemark.inlandWater);
                NSLog(@"locality: %@", placemark.locality);
                NSLog(@"name: %@", placemark.name);
                NSLog(@"ocean: %@", placemark.ocean);
                NSLog(@"postalCode: %@", placemark.postalCode);
                NSLog(@"region: %@", placemark.region);
                NSLog(@"subAdministrativeArea: %@", placemark.subAdministrativeArea);
                NSLog(@"subLocality: %@", placemark.subLocality);
                NSLog(@"subThoroughfare: %@", placemark.subThoroughfare);
                NSLog(@"thoroughfare: %@", placemark.thoroughfare);
                
                // 住所のテキストフィールドに反映
                NSString *formattedAddress = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@" "];
                
                self.txtMessage.text = formattedAddress;
                
            }
        }
    }];

    
    // ここで任意の処理
    NSLog(@"%s | %@, %@", __PRETTY_FUNCTION__, newLocation, oldLocation);
}

// 標準位置情報サービス・大幅変更位置情報サービスの取得に失敗した場合
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // ここで任意の処理
    NSLog(@"%s | %@", __PRETTY_FUNCTION__, error);
    
    if ([error code] == kCLErrorDenied) {
        // 位置情報の利用が拒否されているので停止
        [manager startUpdatingLocation];
    }
}


- (IBAction)onCameraClicked:(id)sender
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.allowsEditing = NO;
    
    // モーダルビューとしてカメラ画面を呼び出す
    [self presentViewController:ipc animated:YES completion:nil];
}

- (IBAction)onPhotoLibraryClicked:(id)sender
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = NO;
    
    // モーダルビューとしてカメラ画面を呼び出す
    [self presentViewController:ipc animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.imgAttach.image = image;
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[DAHelper documentPath:@"attach.jpg"] atomically:YES];
    _message.contentType = message_contenttype_image;
    self.btnClearImg.hidden = NO;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        _photoFromCamera = YES;
    } else {
        _photoFromCamera = NO;
    }
    [self renderButtons];
}

- (IBAction)onAtClicked:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.delegate = self;
    
    int cancelIdx = 1;
    [actionSheet addButtonWithTitle:@"@users"];
    if (![self hasRange]) {
        [actionSheet addButtonWithTitle:@"@groups"];
        cancelIdx = 2;
    }
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:cancelIdx];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnString = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([btnString isEqualToString:@"@groups"]) {
        DAGroupSelectViewController *ctrl = [[DAGroupSelectViewController alloc]initWithNibName:@"DAGroupSelectViewController" bundle:nil];
        ctrl.allowMultiSelect = YES;
        ctrl.selectedBlocks = ^(NSArray *groups){
            _atGroups = [NSMutableArray arrayWithArray:groups];
            [self renderButtons];
        };
        ctrl.selectedGroups = _atGroups;
        [self presentViewController:ctrl animated:YES completion:nil];
    }
    if ([btnString isEqualToString:@"@users"]) {
        DAMemberSelectViewController *ctrl = [[DAMemberSelectViewController alloc]initWithNibName:@"DAMemberSelectViewController" bundle:nil];
        ctrl.allowMultiSelect = YES;
        ctrl.selectedBlocks = ^(NSArray *users){
            _atUsers = [NSMutableArray arrayWithArray:users];
            [self renderButtons];
        };
        ctrl.selectedUsers = _atUsers;
        if ([self hasRange]) {
            ctrl.inGroup = [_rangeGroup objectAtIndex:0];
        }
        [self presentViewController:ctrl animated:YES completion:nil];
    }
}


- (IBAction)onMoticonClicked:(id)sender
{
}

- (IBAction)onClearImgClicked:(id)sender
{
    self.imgAttach.image = nil;
    self.btnClearImg.hidden = YES;
    _message.contentType = message_contenttype_text;
}

- (IBAction)onRangeClicked:(id)sender
{
    DAGroupSelectViewController *ctrl = [[DAGroupSelectViewController alloc]initWithNibName:@"DAGroupSelectViewController" bundle:nil];
    ctrl.selectedGroups = _rangeGroup;
    ctrl.allowMultiSelect = NO;
    ctrl.selectedBlocks = ^(NSArray *groups){
        _rangeGroup = [NSMutableArray arrayWithArray:groups];
        if ([self hasRange]) {
            self.lblRange.text = ((DAGroup *)[_rangeGroup objectAtIndex:0]).name.name_zh;
            [_atGroups removeAllObjects];
            [_atUsers removeAllObjects];
        } else {
            self.lblRange.text = @"公开";
        }
        [self renderButtons];
    };
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (IBAction)onDocumetnClicked:(id)sender {
    DAFileSelectViewController *ctrl = [[DAFileSelectViewController alloc] initWithNibName:@"DAFileSelectViewController" bundle:nil];
    ctrl.selectedFiles = _documents;
    ctrl.allowMultiSelect = NO;
    ctrl.selectedBlocks = ^(NSArray *files){
        _documents = [NSMutableArray arrayWithArray:files];
        if (_documents.count > 0) {
            _message.contentType = message_contenttype_document;
        }
        [self renderButtons];
    };
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (IBAction)onCancelClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSendClicked:(id)sender
{
    _message.content = self.txtMessage.text;
    if (_rangeGroup.count > 0) {
        _message.range = ((DAGroup *)[_rangeGroup objectAtIndex:0])._id;
    } else {
        _message.range = @"1";
    }
    _message.at = [[MessageAt alloc] init];
    if (_atUsers.count > 0) {
        NSMutableArray *users = [[NSMutableArray alloc] init];
        for (DAUser *user in _atUsers) {
            [users addObject:user._id];
        }
        _message.at.users = users;
    }
    if (_atGroups.count > 0) {
        NSMutableArray *groups = [[NSMutableArray alloc] init];
        for (DAGroup *group in _atGroups) {
            [groups addObject:group._id];
        }
        _message.at.groups = groups;
    }
    
    if ([message_contenttype_document isEqualToString:_message.contentType]) {
        NSMutableArray *files = [[NSMutableArray alloc] init];
        for (DAFile *file in _documents) {
            MessageAttach *attach = [[MessageAttach alloc] init];
            attach.fileid = file._id;
            attach.filename = file.filename;
            [files addObject:attach];
        }
        _message.attach = files;
    }
    
    
    if ([message_contenttype_image isEqualToString:_message.contentType]) {
        NSString *file = [DAHelper documentPath:@"attach.jpg"];
        if ([DAHelper isFileExist:file]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:file];
            [[DAFileModule alloc] uploadFile:UIImageJPEGRepresentation(image, 1.0)
                                    fileName:file mimeType:@"image/jpg"
                                    callback:^(NSError *error, DAFile *file){
                
                MessageAttach *attach = [[MessageAttach alloc] init];
                attach.fileid = file._id;
                attach.filename = file.filename;
                _message.attach = [NSArray arrayWithObjects:attach, nil];
                
                [self sendMessage:_message];
                
            } progress:nil];
        } else {
            // TODO error
        }
    } else {
        if (_isForward) {
            [self forwardMessage:_message];
        } else {
            [self sendMessage:_message];
        }
    }
}

-(void)sendMessage:(DAMessage *)message
{
    [[DAMessageModule alloc] send:message callback:^(NSError *error, DAMessage *message){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)forwardMessage:(DAMessage *)message
{
    [[DAMessageModule alloc] forward:message callback:^(NSError *error, DAMessage *message){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(BOOL)hasRange
{
    return _rangeGroup.count > 0;
}

-(BOOL)hasAt
{
    return _atUsers.count > 0 || _atGroups.count >0;
}

@end
