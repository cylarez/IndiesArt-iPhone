//
//  ImageDetail.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageDetail.h"

@implementation ImageDetail

@synthesize navigationController, imageInfoView, controller, imageLabel;


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    BOOL landscape = FALSE;
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || 
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        landscape = TRUE;
    }
    
    // Animate the image info
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.3];
    int y = navigationController.navigationBarHidden ? (landscape ? 220 : 380) : 480;
    CGRect frame = imageInfoView.frame;
    frame.origin.y = y;
    imageInfoView.frame=frame;  
    [UIView commitAnimations];

    // Show/Hide the navigation bar
    [navigationController setNavigationBarHidden:(navigationController.navigationBarHidden ? NO : YES) animated:YES];
}

- (void)rotateImage
{
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.transform = CGAffineTransformIdentity;
    self.transform =
    CGAffineTransformMakeRotation(M_PI * (90) / 180.0);
    self.bounds = CGRectMake(0.0f, 0.0f, 480.0f, 320.0f);
    self.center = CGPointMake(160.0f, 240.0f);
    [UIView commitAnimations];
}

- (void)shareImageFacebook
{
    [controller shareImageFacebook];
}

- (void)shareImageTwitter
{
    [controller shareImageTwitter];
}

- (void)shareImageEmail
{
    [controller shareImageEmail];
}

- (void)viewArtist
{   
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.center = controller.scrollView.center;
    [activityView startAnimating];    
    [artistButton addSubview:activityView]; 
    [self performSelector:@selector(_viewArtist) withObject:nil afterDelay:0];
}

- (void)_viewArtist
{
    ArtistDetailViewController *viewController = [[ArtistDetailViewController alloc] initWithNibName:@"ArtistDetailViewController" bundle:[NSBundle mainBundle]];
    viewController.artist_id= [[imageData valueForKey:@"artist"] valueForKey:@"id"];
	[navigationController pushViewController:viewController animated:YES];
    [activityView stopAnimating];
    [activityView release];
    activityView = nil;
	[viewController release];
	viewController = nil;
}

- (void)loadImageFromURL:(NSString *)url
{
    // Insert loading 
    activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0,0,50,50)];

    activityView.activityIndicatorViewStyle =  [self getSpinnerStyle];
    activityView.center = self.center;
    [activityView startAnimating];    
    [controller.scrollView addSubview:activityView]; 
    [super loadImageFromURL:url];
    
}

- (void)displayImage
{
    [super displayImage];
    
    BOOL landscape = FALSE;
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || 
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        landscape = TRUE;
    }
    
    int width = landscape ? 480 : 320;
    
    imageInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, landscape ? 220 : 380, width, 100)];
    
    // Create image info
    imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 110)];
    imageLabel.backgroundColor = [UIColor blackColor];
    imageLabel.alpha = 0.7;
    
    UILabel *imageLabelText = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 300, 100)];
    imageLabelText.lineBreakMode = UILineBreakModeWordWrap;
    imageLabelText.numberOfLines = 2;
    imageLabelText.textColor = [UIColor whiteColor];
    imageLabelText.backgroundColor = [UIColor clearColor];
    imageLabelText.text = [NSString stringWithFormat:@"%@ %@", [[imageData valueForKey:@"artist"] valueForKey:@"name"], [imageData valueForKey:@"name"]];
    
    // Create FB button
    UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fbButton addTarget:self action:@selector(shareImageFacebook) forControlEvents:UIControlEventTouchDown];
    fbButton.frame = CGRectMake(15, 5, 87, 30);
    [fbButton setImage:[UIImage imageNamed:@"facebook_button.png"] forState:UIControlStateNormal];
    
    // Create Twitter button
    UIButton *twButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twButton addTarget:self action:@selector(shareImageTwitter) forControlEvents:UIControlEventTouchDown];
    twButton.frame = CGRectMake(117, 5, 87, 30);
    [twButton setImage:[UIImage imageNamed:@"twitter_button.png"] forState:UIControlStateNormal];
    
    
    
    [self addSubview:imageInfoView];
    [imageInfoView addSubview:imageLabel];
    [imageInfoView addSubview:imageLabelText];
    
    artistButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    artistButton.frame = CGRectMake(219, 5, 87, 30);
    
    // Add button to view artist (if from discover) OR to email
    if (! controller.artist_id) {
        [artistButton addTarget:self action:@selector(viewArtist) forControlEvents:UIControlEventTouchDown];
        [artistButton setImage:[UIImage imageNamed:@"artist_button.png"] forState:UIControlStateNormal];
    } else {
        [artistButton addTarget:self action:@selector(shareImageEmail) forControlEvents:UIControlEventTouchDown];
        [artistButton setImage:[UIImage imageNamed:@"email_button.png"] forState:UIControlStateNormal];
    }
    [imageInfoView addSubview:artistButton];
    
    [imageInfoView addSubview:twButton];
    [imageInfoView addSubview:fbButton];
    [imageLabel release];
    [imageLabelText release];
    
    NSLog(@"Stop animating");
    [activityView stopAnimating];

}

- (int) getSpinnerStyle
{
    return UIActivityIndicatorViewStyleWhiteLarge;
}


@end
