//
//  DAMessageAtView.h
//  TribeIPhone
//
//  Created by kita on 13-4-21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAMessage.h>

@protocol DAMessageAtViewDelegate
-(void)atUserClicked:(DAUser *)user;
-(void)atGroupClicked:(DAGroup *)group;
@end

@interface DAMessageAtView : UIView
{
    NSMutableArray *touchLocations;
    NSMutableArray *touchContents;
}
@property (nonatomic, strong) id<DAMessageAtViewDelegate> delegate;
-(UIView *)initWithMessage:(DAMessage *)message frame:(CGRect)frame;
@end
