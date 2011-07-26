//
//  IndiesArtViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IndiesArtViewController.h"


@implementation IndiesArtViewController

@synthesize appDelegate, artists, submissions, selectedIndexPath;


-(UIImageView*)getCellArrow
{    
    UIImageView *image = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]] autorelease];
    return image;
    
}

- (void)_loadArtist
{
    ArtistDetailViewController *viewController = [[ArtistDetailViewController alloc] initWithNibName:@"ArtistDetailViewController" bundle:[NSBundle mainBundle]];
    
    NSArray *data = (selectedIndexPath.section == 2) ? submissions : artists;
    
    NSDictionary *selectedArtist = [data objectAtIndex:selectedIndexPath.row];
    
    id artist_id = [selectedArtist valueForKey:@"id"];
    viewController.artist_id= artist_id;
    
	[self.navigationController pushViewController:viewController animated:YES];
    
	[viewController release];
	viewController = nil;
    [data release];
}

-(void)loadArtist
{
    [self performSelector:@selector(_loadArtist) withObject:self afterDelay:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set the loading activity
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.selectedIndexPath = indexPath;
    
    
    [activityView startAnimating];
	[cell setAccessoryView:activityView];
	[activityView release];
    [self performSelector:@selector(loadArtist) withObject:self afterDelay:0];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
	if (selectedIndexPath) {
        UITableViewCell  *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        UIActivityIndicatorView *activityView = (UIActivityIndicatorView *) cell.accessoryView;
        [activityView stopAnimating];
        [cell setAccessoryView:[self getCellArrow]];
	}
}

@end
