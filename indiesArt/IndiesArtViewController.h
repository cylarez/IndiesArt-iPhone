//
//  HomeViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indiesArtAppDelegate.h"
#import "SlideCell.h"

@interface IndiesArtViewController : UITableViewController  {

	indiesArtAppDelegate* appDelegate;    
    NSIndexPath *selectedIndexPath;
    NSArray *artists, *submissions;
}

@property (nonatomic, retain) indiesArtAppDelegate *appDelegate;
@property (nonatomic, retain) NSArray *artists, *submissions;

- (UIImageView*)getCellArrow;

@end
