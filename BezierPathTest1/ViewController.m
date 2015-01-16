//
//  ViewController.m
//  BezierPathTest1
//
//  Created by Cameron Ehrlich on 9/24/12.
//  Copyright (c) 2012 Cameron Ehrlich. All rights reserved.
//

#import <UIBezierPathSerialization.h>
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.sectionImages = @[@"sxn_0", @"sxn_1", @"sxn_2", @"sxn_3", @"sxn_4", @"sxn_5", @"sxn_6", @"sxn_7", @"sxn_8"];
    
    UIImage *sampleImage = [UIImage imageNamed:[self.sectionImages firstObject]];
    
    CGRect sxnFrame = CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.width/sampleImage.size.width) * sampleImage.size.height);
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:sxnFrame];
    [self.backgroundImageView setContentMode:UIViewContentModeScaleToFill];
    
    [self.backgroundImageView setImage:[UIImage imageNamed:[self.sectionImages firstObject]]];
    [self.view addSubview:self.backgroundImageView];
    
    self.drawView = [[BSDrawView alloc] initWithFrame:sxnFrame];
    [self.drawView setClosePathOnFingerLift:YES];
    [self.view addSubview:self.drawView];
    
    for (UIView *view in @[self.sendButton, self.undoButton, self.clearButton, self.stepper]) {
        [self.view bringSubviewToFront:view];
    }
}

- (IBAction)updateImage:(id)sender
{
    NSString *imgString = [self.sectionImages objectAtIndex:self.stepper.value];
    [self.backgroundImageView setImage:[UIImage imageNamed:imgString]];
    [self.currentImageLabel setText:imgString];
}

- (IBAction)newLayer:(id)sender
{
    [self.drawView clear];
}

- (IBAction)undoAction:(id)sender
{
    [self.drawView undo];
}

- (IBAction)saveAndSend:(id)sender
{
    CGFloat scaleFactor = self.backgroundImageView.image.size.width/self.view.bounds.size.width;
    
    UIBezierPath *scaledPath = [BSDrawView scaledPath:[self.drawView bezierPathFromAllPaths]
                                          scaleFactor:scaleFactor];
    NSError *error;
    NSData *pathData = [UIBezierPathSerialization dataWithBezierPath:scaledPath
                                                             options:0
                                                               error:&error];
    if (error) {
        NSLog(@"%@", error.debugDescription);
    }

    MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
    [email setMailComposeDelegate:self];
    [email setToRecipients:@[@"brainstem101app@gmail.com", @"cameronehrlich@gmail.com"]];
    int sectionNumber = (int)[self.stepper value];
    [email addAttachmentData:pathData mimeType:@"application/json" fileName:[NSString stringWithFormat:@"name-type-%d.json", sectionNumber]];
    [self presentViewController:email animated:YES completion:nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

@end
