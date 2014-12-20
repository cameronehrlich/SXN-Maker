    //
    //  ViewController.m
    //  BezierPathTest1
    //
    //  Created by Cameron Ehrlich on 9/24/12.
    //  Copyright (c) 2012 Cameron Ehrlich. All rights reserved.
    //

#import "ViewController.h"
#import "MainView.h"

@interface ViewController (){
    MainView *m;
    UIBezierPath *newPath;
    NSMutableArray *pix;
    CGPoint currentPoint;
    
    NSMutableArray *pathArray;
    NSMutableArray *pathItemArray;
}

@end

@implementation ViewController
@synthesize lineWidthLabel;
@synthesize currentImageLabel;
@synthesize stepper;
@synthesize closePathSwitch;
@synthesize nameAndTypeField;

- (void)viewDidLoad
{
    float scaleFactor = .78;
    m = [[MainView alloc] initWithFrame:CGRectMake(0, 0, scaleFactor*1314, scaleFactor*868)];
    [self.view addSubview:m];
    
    pathArray = [[NSMutableArray alloc] init];
    pathItemArray = [[NSMutableArray alloc] init];
    newPath = [[UIBezierPath alloc] init];
    newPath.flatness = 0.0;
    
    pix = [[NSMutableArray alloc] initWithObjects: @"sxn_0.png", @"sxn_1.png", @"sxn_2.png", @"sxn_3.png", @"sxn_4.png", @"sxn_5.png", @"sxn_6.png", @"sxn_7.png", @"sxn_8.png", nil];
    
    [m.imgView setImage:[UIImage imageNamed:[pix objectAtIndex:0]]];
    
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)updateImage:(id)sender{
    NSString *imgString = [pix objectAtIndex:stepper.value];
    [m.imgView setImage:[UIImage imageNamed:imgString]];
    [currentImageLabel setText:imgString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    currentPoint = [[touches anyObject] locationInView:m];
    if (CGRectContainsPoint(nameAndTypeField.frame, currentPoint)) {
        [nameAndTypeField becomeFirstResponder];
        return;
    }
    
    if(CGRectContainsPoint(m.frame, currentPoint)){
        
        [newPath moveToPoint:currentPoint];
        NSValue *point = [NSValue valueWithCGPoint:currentPoint];
        [pathItemArray addObject:point];
        [m setPath:newPath];
        [m overlay];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    currentPoint = [[touches anyObject] locationInView:m];
    
    if(CGRectContainsPoint(m.frame, currentPoint)){
        [newPath addLineToPoint:currentPoint];
        NSValue *point = [NSValue valueWithCGPoint:currentPoint];
        [pathItemArray addObject:point];
        [m setPath:newPath];
        [m overlay];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    currentPoint = [[touches anyObject] locationInView:m];
    
    if(CGRectContainsPoint(m.frame, currentPoint)){
        if (closePathSwitch.on) {
            [newPath closePath];
        }
        [m setPath:newPath];
        [m overlay];
        
        NSValue *point = [NSValue valueWithCGPoint:currentPoint];
        [pathItemArray addObject:point];
        
        [pathArray addObject:[pathItemArray copy]];
        [pathItemArray removeAllObjects];
    }
}


- (IBAction)updateLineWidth:(UISlider *)sender {
    [m setLineWidth:[NSNumber numberWithFloat:(sender.value*10)+1]];
    [lineWidthLabel setText:[NSString stringWithFormat:@"%d px",[NSNumber numberWithFloat:(sender.value*10)+1].intValue]];
    [m setPath:newPath];
    [m overlay];
}


-(IBAction)newLayer:(id)sender{
    [newPath removeAllPoints];
    [pathArray removeAllObjects];
    [pathItemArray removeAllObjects];
    [m setPath:newPath];
    [m overlay];
}

-(IBAction)undoAction:(id)sender{
    if ([pathArray count] < 1) {
        return;
    }
    [pathArray removeLastObject];
    [pathItemArray removeAllObjects]; //maybe not ness..
    
    newPath = [self convertArrayToBezierPath:pathArray];
    [m setPath:newPath];
    [m overlay];
}

-(UIBezierPath *)convertArrayToBezierPath:(NSMutableArray *)input{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for(int i = 0; i< [input count]; i++){
        [path moveToPoint:[[[input objectAtIndex:i] objectAtIndex:0] CGPointValue]]; //move to
        for(int j = 0; j < [[input objectAtIndex:i] count]; j++){
            [path addLineToPoint:[[[input objectAtIndex:i] objectAtIndex:j] CGPointValue]];
        }
        if (closePathSwitch.on) {
            [path closePath];
        }
    }
    
    return path;
}

-(IBAction)saveAndSend:(id)sender{
    MFMailComposeViewController *email = [[MFMailComposeViewController alloc] init];
    
    [email setMessageBody:[NSString stringWithFormat:@"%@\n\n%@", currentImageLabel.text , [pathArray description]] isHTML:NO];
    [email setSubject:nameAndTypeField.text];
    [email setToRecipients:[NSArray arrayWithObject:@"brainstem101app@gmail.com"]];
    email.mailComposeDelegate = self;
    [self presentViewController:email animated:YES completion:nil];
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
