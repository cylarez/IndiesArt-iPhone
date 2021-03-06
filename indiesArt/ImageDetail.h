//
//  ImageDetail.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "asyncImageView.h"
#import "CollectionViewController.h"
@class CollectionViewController;
#import "ArtistDetailViewController.h"

@interface ImageDetail : AsyncImageView {
    
    UINavigationController *navigationController;
    UIView *imageInfoView;
    CollectionViewController *controller;
    UIButton *artistButton;
    UIActivityIndicatorView *activityView;
    NSDictionary *artist;
    UILabel *imageLabel;
}

@property(nonatomic, retain) UINavigationController *navigationController;
@property(nonatomic, retain) UIView *imageInfoView;
@property(nonatomic, retain) UILabel *imageLabel;
@property(nonatomic, retain) CollectionViewController *controller;

@end
