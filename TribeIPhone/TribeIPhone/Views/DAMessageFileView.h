//
//  DAMessageFileView.h
//  TribeIPhone
//
//  Created by kita on 13-4-23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAMessage.h>

@interface DAMessageFileView : UIView
-(UIView *)initWithMessage:(DAMessage *)message frame:(CGRect)frame;
@end
