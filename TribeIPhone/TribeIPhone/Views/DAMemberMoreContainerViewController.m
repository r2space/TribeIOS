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
    
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"DAMemberMoreViewController" bundle:nil];
    moreViewController = [stryBoard instantiateInitialViewController];
    
    moreViewController.uid = self.uid;
    moreViewController.view.frame = CGRectMake(0, 44, 320, 548);
    [self addChildViewController:moreViewController];
    [self.view addSubview:moreViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)onSaveTouched:(id)sender {
    
    NSString *file = [DAHelper documentPath:@"upload.jpg"];
    
    if ([DAHelper isFileExist:file]) {
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:file];
        [[DAFileModule alloc] uploadFile:UIImageJPEGRepresentation(image, 1.0) fileName:file mimeType:@"image/jpg" callback:^(NSError *error, DAFile *file){

            // TODO: 获取待更新的用户Object
            DAUser *user = [[DAUser alloc] init];
            user._id = moreViewController.uid;
            
            UserName *uname = [[UserName alloc] init];
            user.name = uname;
            user.name.name_zh = moreViewController.txtName.text;
            // user.email
            // user.tel
            
//            user.photo
//            user.photo.fid
//            user.photo.x
//            user.photo.y
//            user.photo.width

            [[DAUserModule alloc] update:user callback:^(NSError *error, DAUser *user){
                NSLog(@"didFinishUpdate");
            }];
        } progress:nil];
        
    } else {

        // TODO: 获取待更新的用户Object
        DAUser *user = [[DAUser alloc] init];
        user._id = moreViewController.uid;
        
        UserName *uname = [[UserName alloc] init];
        user.name = uname;
        user.name.name_zh = moreViewController.txtName.text;

        [[DAUserModule alloc] update:user callback:^(NSError *error, DAUser *user){
            NSLog(@"didFinishUpdate");
        }];

    }
}

- (void) didFinishUpdate
{
    NSLog(@"didFinishUpdate");
}

@end
