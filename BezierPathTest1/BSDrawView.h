//
//  SmoothLineView.h
//  Smooth Line View
//
//  Created by Levi Nunnink on 8/15/11.
//  Copyright 2011 culturezoo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BSDrawView : UIView

@property (nonatomic, strong) NSMutableArray   *drawingPaths;
@property (nonatomic, strong) UIColor          *lineColor;
@property (nonatomic, assign) CGFloat          lineWidth;
@property (nonatomic, assign) CGMutablePathRef constuctionPath;
@property (nonatomic, assign) BOOL             empty;
@property (nonatomic, assign) BOOL             closePathOnFingerLift;

- (void)undo;
- (void)clear;
- (UIBezierPath *)bezierPathFromAllPaths;
+ (UIBezierPath *)scaledPath:(UIBezierPath *)path scaleFactor:(CGFloat)scaleFactor;

@end
