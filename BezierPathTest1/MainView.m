//
//  MainView.m
//  BezierPathTest1
//
//  Created by Cameron Ehrlich on 9/24/12.
//  Copyright (c) 2012 Cameron Ehrlich. All rights reserved.
//

#import "MainView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainView

@synthesize imgView;
@synthesize overlayView;
@synthesize path;
@synthesize lineWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.frame = frame;
        
        imgView = [[UIImageView alloc] initWithFrame:frame];
        overlayView = [[UIImageView alloc] initWithFrame:frame];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:imgView];
        [self addSubview:overlayView];
        
        lineWidth = [[NSNumber alloc] initWithFloat:5.0];
        
    }
    return self;
}

-(void)overlay
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextClearRect(currentContext, self.frame);

    [[UIColor yellowColor] setStroke];
    CGContextSetLineWidth(currentContext, lineWidth.floatValue);
    CGContextSetLineCap(currentContext,  kCGLineCapRound);

    CGContextBeginPath(currentContext);
    CGContextAddPath(currentContext, path.CGPath);
    CGContextDrawPath(currentContext, kCGPathStroke);

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [overlayView setImage:img];
}

@end
