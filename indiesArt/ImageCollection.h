//
//  ImageCollection.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncImageView.h"
#import "CollectionViewController.h"
@class ArtistDetailViewController;

@interface ImageCollection : AsyncImageView {
    UINavigationController * navigationController;
    int index;
    ArtistDetailViewController *controller;
}

@property(nonatomic, retain) UINavigationController *navigationController;
@property(nonatomic) int index;
@property(nonatomic, retain) ArtistDetailViewController *controller;

@end
