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
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"DAGroupMoreViewController" bundle:nil];
    moreViewController = [stryBoard instantiateInitialViewController];
    
    moreViewController.group = self.group;
    moreViewController.view.frame = CGRectMake(0, 44, 320, 548);
    [self addChildViewController:moreViewController];
    [self.view addSubview:moreViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSaveTouched:(id)sender
{
    
    NSString *file = [DAHelper documentPath:@"upload.jpg"];
    
    if ([DAHelper isFileExist:file]) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:file];
        [[DAFileModule alloc] uploadFile:UIImageJPEGRepresentation(image, 1.0) fileName:file mimeType:@"image/jpg" callback:^(NSError *error, DAFile *file){
            DAGroup *g = [[DAGroup alloc] init];
            
            // 新创建组的时候，不指定gid
            if (moreViewController.group != nil) {
                g._id = moreViewController.group._id;
            }
            
            GroupName *name = [[GroupName alloc] init];
            name.name_zh = moreViewController.txtName.text;
            g.name = name;
            
            g.description = moreViewController.txtDescription.text;
            
            GroupPhoto * photo = [[GroupPhoto alloc] init];
            photo.big = file._id;
            g.photo = photo;
            
            if (moreViewController.group == nil) {
                [[DAGroupModule alloc] create:g callback:^(NSError *error, DAGroup *group) {
                NSLog(@"didFinishUpdate");
                }];
            } else {
                [[DAGroupModule alloc] update:g callback:^(NSError *error, DAGroup *group) {
                    NSLog(@"didFinishUpdate");
                }];
            }

        } progress:nil];
    } else {
        DAGroup *g = [[DAGroup alloc] init];
        
        // 新创建组的时候，不指定gid
        if (moreViewController.group != nil) {
            g._id = moreViewController.group._id;
        }
        
        GroupName *name = [[GroupName alloc] init];
        name.name_zh = moreViewController.txtName.text;
        g.name = name;
        
        g.description = moreViewController.txtDescription.text;
        
        if (moreViewController.group == nil) {
            [[DAGroupModule alloc] create:g callback:^(NSError *error, DAGroup *group) {
                NSLog(@"didFinishUpdate");
            }];
        } else {
            [[DAGroupModule alloc] update:g callback:^(NSError *error, DAGroup *group) {
                NSLog(@"didFinishUpdate");
            }];
        }
    }
}

@end
