//
//  ImageCollection.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageCollection.h"


@implementation ImageCollection

@synthesize navigationController, images, index;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CollectionViewController *viewController	=	[[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:[NSBundle mainBundle]];
    
	NSArray *imagesCopy = [images copy];
    viewController.images = imagesCopy;
    [imagesCopy release];
    
    for (NSDictionary *img in images) {
        NSLog(@"URL : %@", [img valueForKey:@"url"]);
    }
    
    viewController.mainImageUrl = [self.imageData valueForKey:@"url"];
    viewController.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:viewController animated:YES];
    
    NSLog(@" index %i", self.index);
    
    [viewController setupPage: self.index];
    
	[viewController release];
	viewController = nil;
    
}

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
