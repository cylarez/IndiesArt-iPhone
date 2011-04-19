//
//  ArtistsViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indiesArtAppDelegate.h"
#import "asyncImageView.h"
#import "ArtistDetailViewController.h"

@interface ArtistsViewController : UITableViewController {
    indiesArtAppDelegate* appDelegate;
    NSArray* artists;
}

@property (nonatomic, retain) NSArray *artists;

@end
