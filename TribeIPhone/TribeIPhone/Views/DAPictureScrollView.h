//
//  DAPictureScrollView.h
//  TribeIPhone
//
//  Created by Antony on 13-6-19.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAPictureScrollView : UIScrollView <UIScrollViewDelegate>
-(void)renderWithPictureIds:(NSArray *)pictureIds;
@end
