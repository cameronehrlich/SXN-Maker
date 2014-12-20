//
//  ViewController.h
//  BezierPathTest1
//
//  Created by Cameron Ehrlich on 9/24/12.
//  Copyright (c) 2012 Cameron Ehrlich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController<MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lineWidthLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentImageLabel;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UISwitch *closePathSwitch;
@property (strong, nonatomic) IBOutlet UITextField *nameAndTypeField;

@end
