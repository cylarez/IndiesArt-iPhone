//
//  ImageCollection.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageCollection.h"


@implementation ImageCollection

@synthesize navigationController, index;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CollectionViewController *viewController	=	[[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:[NSBundle mainBundle]];
    viewController.mainImageUrl = [self.imageData valueForKey:@"url"];
    viewController.hidesBottomBarWhenPushed = YES;
    
    viewController.artist = [self.imageData valueForKey:@"_artist"];
    if ([imageData valueForKey:@"artist"]) {
        [viewController.artist setValue:[[imageData valueForKey:@"artist"] valueForKey:@"name"] forKey:@"name"];
        [viewController.artist setValue:[[imageData valueForKey:@"artist"] valueForKey:@"id"] forKey:@"_id"];
    }
	[self.navigationController pushViewController:viewController animated:YES];
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
