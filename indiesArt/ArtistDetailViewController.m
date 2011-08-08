//
//  ArtistDetailViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtistDetailViewController.h"


@implementation ArtistDetailViewController

@synthesize artist_id, scrollView, images;


-(void)loadImages:(BOOL)just_orientation
{        
    BOOL landscape = FALSE;
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || 
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        landscape = TRUE;
    }
    
    int imageHeight = 103;
    int imageWidth = 103;
    int border = 10;
    int x = border;
    int yBase = artist_id ? 140 : border;
    int y = yBase;
    int c = 1;
    int index = 0;
    
    int numImageRow = landscape ? 4 : 3;
    if (landscape) {
        imageWidth += border / 2;
        imageHeight += border / 2;
    } else {
        imageWidth -= border;
        imageHeight -= border;
    }
    
    if (! just_orientation) {
        if (artist_id) {
            artistLabel.text = [artist valueForKey:@"name"];
        }
        for (ImageCollection *image in [scrollView subviews]) {
            if ([image isKindOfClass:[ImageCollection class]]) {
                [image removeFromSuperview];
            }
        }
    }

    for (NSMutableDictionary *i in images) {
        if (c > numImageRow) {
            y += imageHeight + border;
            x = border;
            c = 1;
        }
        CGRect frame = CGRectMake(x, y, imageWidth , imageHeight );
        
        if (just_orientation) {
            ImageCollection * asyncImage = (ImageCollection*) [i valueForKey:@"view"];
            asyncImage.frame = frame;
        } else {
            ImageCollection * asyncImage = [[[ImageCollection alloc] initWithFrame:frame] autorelease];
            [asyncImage loadImageFromURL:[i valueForKey:@"url_200x200"]];
            asyncImage.userInteractionEnabled = TRUE;
            asyncImage.index = index;
            
            if (! [i valueForKey:@"artist"]) {
                [i setValue:artist forKey:@"artist"];
            }
            asyncImage.controller = self;
            asyncImage.imageData = i;
            asyncImage.navigationController = self.navigationController;
            [i setValue:asyncImage forKey:@"view"];
            [self.view addSubview:asyncImage];
        }
        
        index++;
        x += imageWidth + border;
        c++;
    }
    [scrollView setContentSize:CGSizeMake(300, y + (imageHeight + border))];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (void)_reloadData
{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@", INDIE_URL, ARTIST_URL, artist_id];
    self.artist = [appDelegate downloadData: url];
    self.images = [artist valueForKey:@"images"];
}

- (IBAction)reloadData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading";
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self _reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadImages:FALSE];
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        });
    });
}

- (void)viewDidLoad
{
    
    if (! artist_id) {
        artistPanel.hidden = YES;
    }
    
    [super viewDidLoad];
    artistLabel.font = [UIFont fontWithName:@"Impact" size:22];
    appDelegate = (indiesArtAppDelegate*)[[[UIApplication sharedApplication] delegate] retain];
    [self reloadData];
}

- (void)viewDidUnload
{
    [[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [scrollView release];
    scrollView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)changeOrientation
{
    int scroll_width = 320;
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || 
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        scroll_width = 480;
    } 
    
    scrollView.frame = CGRectMake(0, 0, scroll_width, scrollView.frame.size.height);
    [self loadImages:TRUE];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self changeOrientation];
    [super viewWillAppear:animated];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self changeOrientation];
}

@end
