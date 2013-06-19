//
//  DAPictureViewController.m
//  TribeIPhone
//
//  Created by kita on 13-5-20.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAPictureViewController.h"
#import "MBProgressHUD.h"

#define prictureSpace 0

@interface DAPictureViewController ()

@end

@implementation DAPictureViewController
{
    NSTimeInterval _touchTimer;
    int _currIndex;
}

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
    if (_PictureIds.count > 0) {
        CGSize contentSize = _scrollView.frame.size;
        contentSize.width = contentSize.width * _PictureIds.count + prictureSpace *(_PictureIds.count-1);
        self.scrollView.contentSize = contentSize;
        for (int i = 0; i < _PictureIds.count; i++) {
            [self loadPicture:[_PictureIds objectAtIndex:i] index:i];
        }
    }
    _currIndex = 0;
    [self setTitle];
    [self setBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    _scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPicture:(NSString *)pictureId index:(int)idx
{
    if ([DACommon isImageCatched:pictureId]) {
        [self setPicture:pictureId index:idx];
    } else {
        [[DAFileModule alloc] getPicture:pictureId callback:^(NSError *error, NSString *pid) {
            [self setPicture:pictureId index:idx];
        }];
    }
}

-(void)setPicture:(NSString *)pictureId index:(int)idx
{
    UIImage *img = [DACommon getCatchedImage:pictureId];
    CGSize size = [self sizeFixToImageSize:img.size];
    float x = (_scrollView.frame.size.width + prictureSpace) *idx + (_scrollView.frame.size.width - size.width)/2;
    float y = (_scrollView.frame.size.height - size.height) / 2;
    CGRect viewFrame = CGRectMake(x, y, size.width, size.height);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:viewFrame];
    imgView.image = img;
    [_scrollView addSubview:imgView];
}


-(CGSize)sizeFixToImageSize:(CGSize)imgSize
{
    float maxWidth = _scrollView.frame.size.width;
    float maxHeight = _scrollView.frame.size.height;
    if (imgSize.width <= maxWidth && imgSize.height <= maxHeight) {
        return CGSizeMake(imgSize.width, imgSize.height);
    }
    if (imgSize.width > maxWidth){
        float ratio = imgSize.height / imgSize.width;
        float h = maxWidth * ratio;
        CGSize size = CGSizeMake(maxWidth, h);
        if (h > maxHeight) {
            return [self sizeFixToImageSize:size];
        }
        return size;
    }
    if (imgSize.height > maxHeight) {
        float ratio = imgSize.width / imgSize.height;
        float w = maxHeight *ratio;
        CGSize size = CGSizeMake(w, maxHeight);
        if (w > maxWidth) {
            return [self sizeFixToImageSize:size];
        }
        return size;
    }
    return CGSizeMake(maxWidth, maxHeight);
}

-(void)setTitle
{
    _barTitle.title = [NSString stringWithFormat:@"%d / %d", _currIndex + 1, _PictureIds.count];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setBarHidden:YES];
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int idx = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (_currIndex!=idx) {
        _currIndex = idx;
        [self setTitle];
    }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _touchTimer = [touch timestamp];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _touchTimer = [touch timestamp] - _touchTimer;
    
    NSUInteger tapCount = [touch tapCount];
    if (tapCount == 1 && _touchTimer <= 3){
        [self setBarHidden:!_toolBar.hidden];
    }
        
}

-(void)setBarHidden:(BOOL)hidden
{
    [[UIApplication sharedApplication] setStatusBarHidden:hidden];
    _toolBar.hidden = hidden;
}


- (IBAction)onCloseClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSaveImgClicked:(id)sender {
    NSString *pid = [_PictureIds objectAtIndex:_currIndex];
    if ([DACommon isImageCatched:pid]) {
        UIImageWriteToSavedPhotosAlbum([DACommon getCatchedImage:pid], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }

}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
        MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progress.mode = MBProgressHUDModeText;
        progress.dimBackground = YES;
        progress.labelText = @"";
        progress.detailsLabelText = @"saved";
        progress.margin = 10.f;
        progress.yOffset = 50.f;
        progress.removeFromSuperViewOnHide = YES;
        [progress hide:YES afterDelay:2];
}
@end
