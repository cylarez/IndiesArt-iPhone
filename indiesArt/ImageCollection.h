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

@interface ImageCollection : AsyncImageView {
    UINavigationController * navigationController;
    NSArray *images;
    int index;
}

@property(nonatomic, retain) UINavigationController *navigationController;
@property(nonatomic, copy) NSArray *images;
@property(nonatomic) int index;

@end
