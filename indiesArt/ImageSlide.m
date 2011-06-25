//
//  ImageSlide.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageSlide.h"


@implementation ImageSlide

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

@end
