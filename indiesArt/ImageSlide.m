//
//  ImageSlide.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageSlide.h"


@implementation ImageSlide

@synthesize image, controller;

- (void)displayImage
{
    imageView.alpha = 0;
    
    [imageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageView.layer setBorderWidth: 4.0];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 2];
    imageView.alpha = 1;
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];
    [UIView commitAnimations];
}


-(void)launchArtist
{
    ArtistDetailViewController *viewController = [[ArtistDetailViewController alloc] initWithNibName:@"ArtistDetailViewController" bundle:[NSBundle mainBundle]];
    viewController.artist_id= [image valueForKey:@"id"];
	[controller.navigationController pushViewController:viewController animated:YES];
    self.alpha = 1;
    [activityView stopAnimating];
	[viewController release];
	viewController = nil;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    self.alpha = 0.6;
   
    activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(130, 64, 40, 40)];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [activityView startAnimating];
    [self addSubview:activityView];
    [activityView release];
    
    [self performSelector:@selector(launchArtist) withObject:nil afterDelay:0];
}
    
@end
