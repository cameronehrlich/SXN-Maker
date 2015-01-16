//
//  ViewController.h
//  BezierPathTest1
//
//  Created by Cameron Ehrlich on 9/24/12.
//  Copyright (c) 2012 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "BSDrawView.h"

@interface ViewController : UIViewController<MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *currentImageLabel;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
@property (strong, nonatomic) IBOutlet UIButton *undoButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) BSDrawView *drawView;

@property (strong, nonatomic) NSArray *sectionImages;

@end
