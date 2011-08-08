//
//  AboutViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (indiesArtAppDelegate*)[[[UIApplication sharedApplication] delegate] retain];
    NSString *text = appDelegate.about; 
    textView.text = text;
    [scrollView setContentSize:CGSizeMake(320, 490)];
}

- (IBAction) loadEmailView
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"Contact Us"];
    [controller setToRecipients:[NSArray arrayWithObject:@"info@indiesart.com"]];   
    if (controller) [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email-posted.png"]] autorelease];
        
        // Set custom view mode
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = @"Email Sent!";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:3];
    } 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
