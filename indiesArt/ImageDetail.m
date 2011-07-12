//
//  ImageDetail.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageDetail.h"

@implementation ImageDetail

@synthesize navigationController, image, imageInfoView, controller;


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Animate the image info
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.3];
    int y = navigationController.navigationBarHidden ? 360 : 480;
    CGRect frame = imageInfoView.frame;
    frame.origin.y = y;
    imageInfoView.frame=frame;  
    [UIView commitAnimations];

    // Show/Hide the navigation bar
    [navigationController setNavigationBarHidden:(navigationController.navigationBarHidden ? NO : YES) animated:YES];
}

- (void)shareImage
{
    [controller shareImage];
}

- (void)shareImageTwitter
{
    TwitterRushViewController *viewController	=	[[TwitterRushViewController alloc] initWithNibName:@"TwitterRushViewController" bundle:[NSBundle mainBundle]];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", INDIE_URL, [image valueForKey:@"url_page"]];
    MKBitlyHelper *bitlyHelper = [[MKBitlyHelper alloc] initWithLoginName:BIT_LOGIN andAPIKey:BIT_KEY];
    NSString *shortUrl = [bitlyHelper shortenURL:url];
    NSString *tweet = [NSString stringWithFormat:@"%@ %@ found via @indiesart", [controller.artist valueForKey:@"name"], shortUrl];

    [bitlyHelper release];
    
	[self.navigationController pushViewController:viewController animated:YES];
    viewController.tweetTextField.text = tweet;
    [viewController release];
}

- (void)viewArtist
{   
    activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(31,2.5,25,25)];
    activityView.activityIndicatorViewStyle =  UIActivityIndicatorViewStyleWhite;
    [activityView startAnimating];

    
    [artistButton addSubview:activityView]; 
    [self performSelector:@selector(_viewArtist) withObject:nil afterDelay:0];
}

- (void)_viewArtist
{
    ArtistDetailViewController *viewController = [[ArtistDetailViewController alloc] initWithNibName:@"ArtistDetailViewController" bundle:[NSBundle mainBundle]];
    viewController.artist_id= [controller.artist valueForKey:@"_id"];
	[self.controller.navigationController pushViewController:viewController animated:YES];
    [activityView stopAnimating];
    
    [activityView release];
    activityView = nil;
	[viewController release];
	viewController = nil;
}

- (void)displayImage
{
    [super displayImage];
    imageInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 120)];
    
    // Create image info
    UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 110)];
    imageLabel.textColor = [UIColor whiteColor];
    imageLabel.lineBreakMode = UILineBreakModeWordWrap;
    imageLabel.numberOfLines = 2;
    imageLabel.backgroundColor = [UIColor blackColor];
    imageLabel.alpha = 0.7;
    imageLabel.text = [NSString stringWithFormat:@"%@ %@", [controller.artist valueForKey:@"name"], [image valueForKey:@"name"]];
    
    // Create FB button
    UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fbButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchDown];
    fbButton.frame = CGRectMake(15, 5, 87, 30);
    [fbButton setImage:[UIImage imageNamed:@"facebook_button.png"] forState:UIControlStateNormal];
    
    // Create Twitter button
    UIButton *twButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twButton addTarget:self action:@selector(shareImageTwitter) forControlEvents:UIControlEventTouchDown];
    twButton.frame = CGRectMake(117, 5, 87, 30);
    [twButton setImage:[UIImage imageNamed:@"twitter_button.png"] forState:UIControlStateNormal];
    
    [self addSubview:imageInfoView];
    [imageInfoView addSubview:imageLabel];
    
    if ([controller.artist valueForKey:@"_id"]) {
        artistButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [artistButton addTarget:self action:@selector(viewArtist) forControlEvents:UIControlEventTouchDown];
        artistButton.frame = CGRectMake(219, 5, 87, 30);
        [artistButton setImage:[UIImage imageNamed:@"artist_button.png"] forState:UIControlStateNormal];
        [imageInfoView addSubview:artistButton];
    }
    
    
    
    [imageInfoView addSubview:twButton];
    [imageInfoView addSubview:fbButton];
    [imageLabel release];
}

- (int) getSpinnerStyle
{
    return UIActivityIndicatorViewStyleWhiteLarge;
}


@end
