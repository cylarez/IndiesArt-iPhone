//
//  ImageSlide.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "asyncImageView.h"
#import "HomeViewController.h"
@class HomeViewController;

@interface ImageSlide : AsyncImageView {
    NSDictionary *image;
    HomeViewController *controller;
    UIActivityIndicatorView *activityView;
}

@property(nonatomic, retain) NSDictionary *image;
@property(nonatomic, retain) HomeViewController *controller;

@end
