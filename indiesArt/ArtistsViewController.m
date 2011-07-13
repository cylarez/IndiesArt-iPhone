//
//  ArtistsViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtistsViewController.h"


@implementation ArtistsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[[UIApplication sharedApplication] delegate] retain];
    
    self.artists = [appDelegate.feed valueForKey:@"artists"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [artists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ImageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryView:[self getCellArrow]];
    } else {
        AsyncImageView* oldImage = (AsyncImageView*)[cell.contentView viewWithTag:999];
        [oldImage removeFromSuperview];
    }

    CGRect frame = CGRectMake(7, 7, 44, 44);
    AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
    asyncImage.tag = 999;
    NSDictionary *artist = [artists objectAtIndex:indexPath.row];
    [asyncImage loadImageFromURL:[artist valueForKey:@"image"]];
    
    cell.imageView.image = asyncImage.imageView.image;
    cell.textLabel.text =   [artist valueForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@" %@ images", [artist valueForKey:@"image_number"]];
    [cell.contentView addSubview:asyncImage];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



@end
