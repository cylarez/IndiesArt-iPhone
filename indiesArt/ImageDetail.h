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

@interface ImageDetail : AsyncImageView {
    
    UINavigationController *navigationController;
    NSDictionary *image;
    UIView *imageInfoView;
    CollectionViewController *controller;
}

@property(nonatomic, retain) UINavigationController *navigationController;
@property(nonatomic, retain) NSDictionary *image;
@property(nonatomic, retain) UIView *imageInfoView;
@property(nonatomic, retain) CollectionViewController *controller;

@end
