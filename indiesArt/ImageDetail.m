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

- (void)displayImage
{
    [super displayImage];
    imageInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 120)];
    
    // Create image info
    UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 70)];
    imageLabel.textColor = [UIColor whiteColor];
    imageLabel.lineBreakMode = UILineBreakModeWordWrap;
    imageLabel.numberOfLines = 2;
    imageLabel.backgroundColor = [UIColor blackColor];
    imageLabel.alpha = 0.7;
    imageLabel.text = [NSString stringWithFormat:@"%@ %@", [controller.artist valueForKey:@"name"], [image valueForKey:@"name"]];
    
    // Create FB button
    UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fbButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchDown];
    fbButton.frame = CGRectMake(10, 0, 87, 30);
    [fbButton setImage:[UIImage imageNamed:@"facebook_button.png"] forState:UIControlStateNormal];
    
    // Create Twitter button
    UIButton *twButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twButton addTarget:self action:@selector(shareImageTwitter) forControlEvents:UIControlEventTouchDown];
    twButton.frame = CGRectMake(107, 0, 87, 30);
    [twButton setImage:[UIImage imageNamed:@"twitter_button.png"] forState:UIControlStateNormal];
    
    [self addSubview:imageInfoView];
    [imageInfoView addSubview:imageLabel];
    [imageInfoView addSubview:twButton];
    [imageInfoView addSubview:fbButton];
}

- (int) getSpinnerStyle
{
    return UIActivityIndicatorViewStyleWhiteLarge;
}


@end
