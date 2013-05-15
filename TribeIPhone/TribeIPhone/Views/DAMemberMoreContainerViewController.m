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
            NSMutableDictionary *userdata = [NSMutableDictionary dictionary];
            [userdata setObject:moreViewController.uid forKey:@"_id"];
            [userdata setObject:moreViewController.txtName.text forKey:@"name"];
            [userdata setObject:moreViewController.txtEmail.text forKey:@"email"];
            [userdata setObject:moreViewController.txtMobile.text forKey:@"tel"];
            
            //    [userdata setObject:moreViewController.txtDescription.text forKey:@"description"];
            [userdata setObject:file._id forKey:@"fid"];
            
            [[DAUserUpdatePoster alloc] update:userdata delegateObj:self];
        } progress:nil];
        
    } else {
        NSMutableDictionary *userdata = [NSMutableDictionary dictionary];
        [userdata setObject:moreViewController.uid forKey:@"_id"];
//        [userdata setObject:moreViewController.txtName.text forKey:@"name"];
//        [userdata setObject:moreViewController.txtEmail.text forKey:@"email"];
//        [userdata setObject:moreViewController.txtDescription.text forKey:@"description"];
        
        [[DAUserUpdatePoster alloc] update:userdata delegateObj:self];

    }
}

- (void) didFinishUpdate
{
    NSLog(@"didFinishUpdate");
}

@end
