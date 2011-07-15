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

@interface ArtistDetailViewController : UIViewController {
    NSDictionary* artist;
    NSString* artist_id;
    indiesArtAppDelegate* appDelegate;
    IBOutlet UIScrollView* scrollView;
    NSArray *images;
    MBProgressHUD *HUD;
}

@property (nonatomic, copy) NSDictionary *artist;
@property (nonatomic, retain) NSString *artist_id;
@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, copy) NSArray *images;

-(void)loadImages;


@end
