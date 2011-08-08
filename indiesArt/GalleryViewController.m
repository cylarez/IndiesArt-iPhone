//
//  GalleryViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GalleryViewController.h"

@implementation GalleryViewController

@synthesize facebook, artist;

- (void)viewDidLoad
{
    appDelegate = (indiesArtAppDelegate*)[[[UIApplication sharedApplication] delegate] retain];
    facebook = appDelegate.facebook;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)fbDidLogin
{
	NSLog(@"fb login");
    [self shareImageFacebook];
}

- (NSDictionary*)getArtist
{
    return artist;
}

- (NSString*)getUrl
{
    return [artist valueForKey:@"url"];
}

- (BOOL)isSubmission
{
    id submission = [[self getArtist] valueForKey:@"submission"];
    BOOL isSubmission = [submission boolValue];
    return isSubmission;
}

- (NSString*)getShareText:(BOOL)fromTwitter
{
    NSString *str = nil;
    
    if ([self isSubmission]) {
        str = @"I promote %@ in the indiesArt submission process!";
    } else {
        str = @"%@ found via ";
        str = [str stringByAppendingString:(fromTwitter ? @"@indiesart" : @"indiesart.com")];
    }
    str = [NSString stringWithFormat:str, [[self getArtist] valueForKey:@"name"]];
    
    return str;
}

- (NSString*)getImageUrl
{
     NSString *str = nil;
    
    if ([self isSubmission]) {
        str = [[self getArtist] valueForKey:@"url"];
    } else {
        str = [self getUrl];
    }
    str = [NSString stringWithFormat:@"%@%@", INDIE_URL, str];
    
    return [appDelegate getShortUrl:str];
}

- (void)shareImageTwitter
{
    TwitterRushViewController *viewController	=	[[TwitterRushViewController alloc] initWithNibName:@"TwitterRushViewController" bundle:[NSBundle mainBundle]];
    NSString *tweet = [NSString stringWithFormat:@"%@ %@", [self getShareText:true], [self getImageUrl]];
    
	[self.navigationController pushViewController:viewController animated:YES];
    viewController.tweetTextField.text = tweet;
    [viewController release];
}

-(void)shareImageFacebook
{
    if ([facebook isSessionValid]) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       APP_ID, @"app_id",
                                       [self getImageUrl], @"link",
                                       [self getShareText:false], @"message",
                                       nil];
        
        [facebook dialog:@"feed" andParams:params andDelegate:self];
    } else {
        [self launchFacebook];
    }
}

- (void)shareImageEmail
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:[self getShareText:FALSE]];
    
    NSString *content = [self getShareText:FALSE];
    content = [NSString stringWithFormat:@"%@ <br/> %@%@", content, INDIE_URL,[self getUrl]]; 
    
    NSLog(@"%@", content);
    
    [controller setMessageBody:content isHTML:YES]; 
    if (controller) [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MFMailComposeResultSent) {
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

-(void)launchFacebook
{
    // Init FB Connect
    NSArray *permissions = [[NSArray arrayWithObjects:@"read_stream", @"publish_stream", @"offline_access",nil] retain];
    [facebook authorize:permissions delegate:self];
    [permissions release];
}

- (void)dialogDidComplete:(FBDialog *)dialog {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fb-posted.png"]] autorelease];
	
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"Posted!";
	
    [HUD show:YES];
	[HUD hide:YES afterDelay:3];
}

- (void)imageSaved
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"The Image has been saved" message:@"Please go your iPhone Settings or in the Photos Manager to change your Wallpaper" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
