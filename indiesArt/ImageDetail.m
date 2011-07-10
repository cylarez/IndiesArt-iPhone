//
//  ImageDetail.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageDetail.h"


@implementation ImageDetail

@synthesize navigationController, imageLabel, image, fbButton, imageInfoView;


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

- (void)displayImage
{
    [super displayImage];
    imageInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 120)];
    [self addSubview:imageInfoView];
    
    [imageInfoView addSubview:imageLabel];
    [imageInfoView addSubview:fbButton];
}

- (int) getSpinnerStyle
{
    return UIActivityIndicatorViewStyleWhiteLarge;
}


@end
