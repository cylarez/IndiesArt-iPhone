//
//  ImageDetail.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageDetail.h"


@implementation ImageDetail

@synthesize navigationController, imageLabel;


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Animate the image info
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.3];
    int y = navigationController.navigationBarHidden ? 384 : 480;
    CGRect frame = imageLabel.frame;
    frame.origin.y = y;
    imageLabel.frame=frame;    
    [UIView commitAnimations];

    // Show/Hide the navigation bar
    [navigationController setNavigationBarHidden:(navigationController.navigationBarHidden ? NO : YES) animated:YES];
}

- (void)displayImage
{
    [super displayImage];
    [self addSubview:imageLabel];
}

- (int) getSpinnerStyle
{
    return UIActivityIndicatorViewStyleWhiteLarge;
}


@end
