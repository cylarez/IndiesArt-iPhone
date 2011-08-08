//
//  ArtistDetailViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indiesArtAppDelegate.h"
@class indiesArtAppDelegate;
#import "ImageCollection.h"
#import "GalleryViewController.h"

@interface ArtistDetailViewController : GalleryViewController {
    NSString* artist_id;
    IBOutlet UIScrollView* scrollView;
    IBOutlet UILabel *artistLabel;
    NSArray *images;
    IBOutlet UIView *artistPanel;
}

@property (nonatomic, retain) NSString *artist_id;
@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, copy) NSArray *images;


-(void)loadImages:(BOOL)just_orientation;
-(IBAction)reloadData;


@end
