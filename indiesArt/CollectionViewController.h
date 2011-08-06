//
//  CollectionViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDetail.h"
@class ImageDetail;
#import "indiesArtAppDelegate.h"
@class indiesArtAppDelegate;
#import "GalleryViewController.h"

@interface CollectionViewController : GalleryViewController <UIScrollViewDelegate, UIActionSheetDelegate> {
    IBOutlet UIScrollView *scrollView;
    
    NSString *mainImageUrl;
    IBOutlet ImageDetail *currentImage;
    
    NSArray *images;
    NSString *artist_id;
    
    int called_index;
    
}


@property(nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain)  NSString *mainImageUrl;
@property (nonatomic, retain) ImageDetail *currentImage;

@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain)  NSString *artist_id;

- (void)setupPage:(int)index;
- (void)loadImage:(int)index recursive:(BOOL) recursive;


@end
