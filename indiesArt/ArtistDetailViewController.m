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


-(void)loadImages
{        
    BOOL landscape = FALSE;
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || 
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        //landscape = TRUE;
    }
    
    int imageHeight = 103;
    int imageWidth = 103;
    int border = 10;
    int x = border;
    int yBase = artist_id ? 130 : border;
    int y = yBase;
    int c = 1;
    int index = 0;
    
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Add the artist name Label
    if (artist_id) {
        UIImageView *artistLabelBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label-artist.png"]] autorelease];
        int l_border = landscape ? 82 : 0;
        if (landscape) {
            artistLabelBg.frame = CGRectMake(l_border, 0, artistLabelBg.frame.size.width, artistLabelBg.frame.size.height);
        }
        UILabel *artistLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25, 25, 270, 25)] autorelease];
        artistLabel.lineBreakMode = UILineBreakModeWordWrap;
        artistLabel.numberOfLines = 2;
        artistLabel.textColor = [UIColor blackColor];
        artistLabel.backgroundColor = [UIColor clearColor];
        artistLabel.textAlignment = UITextAlignmentCenter;
        artistLabel.text = [artist valueForKey:@"name"];
        artistLabel.shadowColor = [UIColor grayColor];
        artistLabel.shadowOffset = CGSizeMake(1, 1);
        artistLabel.font = [UIFont fontWithName:@"Impact" size:22];
        
        [artistLabelBg addSubview:artistLabel];
        
        [self.view addSubview:artistLabelBg];

        
        // Set Share buttons
        // Create FB button
        fbButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [fbButton addTarget:self action:@selector(shareImageFacebook) forControlEvents:UIControlEventTouchDown];
        fbButton.frame = CGRectMake(l_border + 65, 82, 87, 30);
        [fbButton setImage:[UIImage imageNamed:@"facebook_button.png"] forState:UIControlStateNormal];
        [self.view addSubview:fbButton];
        
        // Create Twitter button
        twButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [twButton addTarget:self action:@selector(shareImageTwitter) forControlEvents:UIControlEventTouchDown];
        twButton.frame = CGRectMake(l_border + 165, 82, 87, 30);
        [twButton setImage:[UIImage imageNamed:@"twitter_button.png"] forState:UIControlStateNormal];
        [self.view addSubview:twButton];
    }
    
    int numImageRow = landscape ? 4 : 3;
    if (landscape) {
        imageWidth += border / 2;
        imageHeight += border / 2;
    } else {
        imageWidth -= border;
        imageHeight -= border;
    }
    
    for (NSMutableDictionary *i in images) {
        if (c > numImageRow) {
            y += imageHeight + border;
            x = border;
            c = 1;
        }
        
        CGRect frame = CGRectMake(x, y, imageWidth , imageHeight );
        
        ImageCollection * asyncImage = [[[ImageCollection alloc] initWithFrame:frame] autorelease];
        [asyncImage loadImageFromURL:[i valueForKey:@"url_200x200"]];
        asyncImage.userInteractionEnabled = TRUE;
        asyncImage.index = index;
        index++;
        if (! [i valueForKey:@"artist"]) {
            [i setValue:artist forKey:@"artist"];
        }
        asyncImage.controller = self;
        asyncImage.imageData = i;
        asyncImage.navigationController = self.navigationController;
        [self.view addSubview:asyncImage];
        x += imageWidth + border;
        c++;
    }
    
    [scrollView setContentSize:CGSizeMake(300, y + (imageHeight + border))];
}

-(void) detectOrientation {
    
    [[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || 
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        scrollView.frame = CGRectMake(0, 0, 480, scrollView.frame.size.height);
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        scrollView.frame = CGRectMake(0, 0, 320, scrollView.frame.size.height);
    }   
    [self loadImages];
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
            [self loadImages];
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (indiesArtAppDelegate*)[[[UIApplication sharedApplication] delegate] retain];
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    [self reloadData];
}

- (void)viewDidUnload
{
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

@end
