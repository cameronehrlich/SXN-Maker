//
//  MainView.h
//  BezierPathTest1
//
//  Created by Cameron Ehrlich on 9/24/12.
//  Copyright (c) 2012 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainView : UIView

@property (nonatomic,retain) UIImageView *imgView;
@property (nonatomic,retain) UIImageView *overlayView;
@property (nonatomic, retain) UIBezierPath *path;
@property (nonatomic, retain) NSNumber *lineWidth;

-(void)overlay;

@end
