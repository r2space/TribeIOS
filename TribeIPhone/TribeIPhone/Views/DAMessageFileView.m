//
//  DAMessageFileView.m
//  TribeIPhone
//
//  Created by kita on 13-4-23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAMessageFileView.h"

@implementation DAMessageFileView

-(UIView *)initWithMessage:(DAMessage *)message frame:(CGRect)frame
{
    self = [super init];
    [self setBackgroundColor:[UIColor grayColor]];
    if (message.attach.count > 0) {
        float fileX = 10;
        float fileY = 0;
        float fileWidth = frame.size.width - fileX *2;
        float fileHeight = 20;
        for (MessageAttach *file in message.attach) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(fileX, fileY, fileWidth, fileHeight)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingMiddle];
            [label setFont:[UIFont systemFontOfSize:12]];
            label.text = file.filename;
            
            fileY += fileHeight;
            
            [self addSubview:label];
        }
        CGRect viewFrame = frame;
        viewFrame.size.height = fileHeight * message.attach.count;
        self.frame = viewFrame;
    }
    return self;
}

@end
