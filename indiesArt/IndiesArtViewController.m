//
//  IndiesArtViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IndiesArtViewController.h"


@implementation IndiesArtViewController

@synthesize appDelegate, artists, submissions;


-(UIImageView*)getCellArrow
{    
    UIImageView *disclosureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    return disclosureView;
}

-(void)loadArtist    
{
    ArtistDetailViewController *viewController	=	[[ArtistDetailViewController alloc] initWithNibName:@"ArtistDetailViewController" bundle:[NSBundle mainBundle]];
    
    NSArray *data = selectedIndexPath.section == 1 ? artists : submissions;
    NSDictionary *selectedArtist =   [data objectAtIndex:selectedIndexPath.row];
    id artist_id = [selectedArtist valueForKey:@"id"];
    viewController.artist_id= artist_id;
    
	[self.navigationController pushViewController:viewController animated:YES];
    
    UITableViewCell  *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *) cell.accessoryView;
    [activityView stopAnimating];
    
    [cell setAccessoryView:[self getCellArrow]];
    
	[viewController release];
	viewController = nil;
    
}

@end
