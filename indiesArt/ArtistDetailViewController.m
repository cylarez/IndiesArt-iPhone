//
//  ArtistDetailViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtistDetailViewController.h"


@implementation ArtistDetailViewController

@synthesize artist, artist_id, scrollView, images;

-(void)loadImages
{    
    int imageHeight = 103;
    int imageWidth = 103;
    int scrollViewHeight = imageHeight;
    int border = 10;
    int x = border;
    int y = border;
    int c = 1;
    int index = 0;

    for (NSMutableDictionary *i in images) {
        if (c > 3) {
            y += imageHeight;
            x = border;
            c = 1;
            scrollViewHeight += imageHeight;
        }

        CGRect frame = CGRectMake(x, y, imageWidth - border, imageHeight - border);
        
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
        x += imageWidth;
        c++;
    }
    
    [scrollView setContentSize:CGSizeMake(300, scrollViewHeight + border)];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[[UIApplication sharedApplication] delegate] retain];
    
    if (artist_id != nil) {
    
        NSString *url = [NSString stringWithFormat:@"%@/%@/%@", INDIE_URL, ARTIST_URL, artist_id];
        self.artist = [appDelegate downloadData: url];
        images = [artist valueForKey:@"images"];
    }
    
    [self loadImages];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
