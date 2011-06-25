//
//  HomeViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "SlideCell.h"

@implementation HomeViewController


@synthesize scrollView, pageControl, artists, submissions, slides;



#pragma mark -
#pragma mark The Home Scroller
- (void)setupPage
{
	scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
	CGFloat cx = 0;
    int height = 168;
    int width = 300;
    
	for (NSString *imageName in slides) {
        CGRect frame;
        frame.size.width=width; frame.size.height=height; frame.origin.x=0; frame.origin.y=0;
        ImageSlide* asyncImage = [[[ImageSlide alloc] initWithFrame:frame] autorelease];
        
        [asyncImage loadImageFromURL:imageName];

		CGRect rect = asyncImage.frame;
		rect.size.height = height;
		rect.size.width = width;
		rect.origin.x = ((scrollView.frame.size.width - width) / 2) + cx;
		rect.origin.y = ((scrollView.frame.size.height - height) / 2);        
		asyncImage.frame = rect;

		[scrollView addSubview:asyncImage];
        
		cx += scrollView.frame.size.width;
	}
	
	self.pageControl.numberOfPages = [slides count];
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
    
	/*
	 *	We switch page at 50% across
	 */
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    pageControlIsChangingPage = NO;
}

- (IBAction)changePage:(id)sender 
{
	/*
	 *	Change the scroll view
	 */
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
    
	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    pageControlIsChangingPage = YES;
}

#pragma mark - Basic

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
    self.submissions = [appDelegate.feed valueForKey:@"submissions"];
    self.slides = [appDelegate.feed valueForKey:@"slides"];
    
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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (section == 0) {
        return 1;
    } else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {

        static NSString *CellIdentifier = @"SlideCell";
        
        SlideCell *cell = (SlideCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SlideCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        // Configure the cell...
        [self setupPage];
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"ImageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithFrame:CGRectZero reuseIdentifier:CellIdentifier]
                autorelease];
    
        
        UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc] 
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        
        // Spacer is a 1x1 transparent png
        UIImage *spacer = [UIImage imageNamed:@"spacer"];
        
        UIGraphicsBeginImageContext(spinner.frame.size);
        
        [spacer drawInRect:CGRectMake(0,0,spinner.frame.size.width,spinner.frame.size.height)];
        UIImage* resizedSpacer = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        cell.imageView.image = resizedSpacer;
        [cell.imageView addSubview:spinner];
        [spinner startAnimating];
        
        
        CGRect frame;
        frame.size.width=40; frame.size.height=40; frame.origin.x=0; frame.origin.y=0;
        AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        
        NSDictionary *artist;
        if (indexPath.section == 1) {
            artist		=	[artists objectAtIndex:indexPath.row];
        } else {
            artist		=	[submissions objectAtIndex:indexPath.row];
        }

        [asyncImage loadImageFromURL:[artist valueForKey:@"image"]];
        
        cell.textLabel.text			=	[NSString stringWithFormat:@" %@", [artist valueForKey:@"name"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:asyncImage];
        
    }     

    
    

//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        
//        NSDictionary *artist;
//        
//        if (indexPath.section == 1) {
//            artist		=	[artists objectAtIndex:indexPath.row];
//        } else {
//            artist		=	[submissions objectAtIndex:indexPath.row];
//        }
//        
//        NSString *projectImage		=	[artist valueForKey:@"image"];        
//        NSURL *url					=	[NSURL URLWithString: projectImage];
//        NSData *data				=	[NSData dataWithContentsOfURL:url];
//        UIImage *img				=	[[UIImage alloc] initWithData:data];
//
//        cell.imageView.image		=	img;
//        cell.textLabel.text			=	[artist valueForKey:@"name"];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 190;
    }
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Main Current Artists";
    } else if (section == 1) {
        return @"Last Artists";
    } else {
        return @"Last Submissions";
    }
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
//{
//    if (! section) {
//        
//        return nil;
//    }
//    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
//    
//    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"section-header.png"]];;
//    
//	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, -5, tableView.bounds.size.width - 10, 30)] autorelease];
//	
//	//NSArray *sectionSelected		=	[self.projects objectAtIndex:section];
//	//label.text	=	[sectionSelected valueForKey:@"name"];
//    
//    NSString *text = @"";
//    
//    if (section == 1) {
//        text    =   @"Last Artists";
//    } else {
//        text    =   @"Last Submissions";
//    }
//    
//    label.text = text;
//    label.font = [UIFont boldSystemFontOfSize:16];
//	label.textColor = [UIColor colorWithRed :158 green:158 blue:158 alpha:1];
//	label.backgroundColor = [UIColor clearColor];
//	[headerView addSubview:label];
//	
//	return headerView;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *data = indexPath.section == 1 ? artists : submissions;
    
    NSDictionary *artist   =   [data objectAtIndex:[indexPath row]];
    
    ArtistDetailViewController *viewController	=	[[ArtistDetailViewController alloc] initWithNibName:@"ArtistDetailViewController" bundle:[NSBundle mainBundle]];
	
    id artist_id = [artist valueForKey:@"id"];
    viewController.artist_id= artist_id;
    
	[self.navigationController pushViewController:viewController animated:YES];
    
	[viewController release];
	viewController = nil;

}

@end
