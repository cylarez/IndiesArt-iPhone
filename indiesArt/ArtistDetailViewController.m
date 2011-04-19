//
//  ArtistDetailViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtistDetailViewController.h"


@implementation ArtistDetailViewController

@synthesize artist, artist_id, scrollView;

-(void)loadImages
{
    appDelegate = [[[UIApplication sharedApplication] delegate] retain];
    NSString *url = [NSString stringWithFormat:@"%@/%@", ARTIST_URL, artist_id];
    self.artist = [appDelegate downloadData: url];
    NSArray *images = [self.artist valueForKey:@"images"]; 
    NSLog(@"Images length %i", [images count]);
    
    int imageHeight = 103;
    int imageWidth = 103;
    int scrollViewHeight = imageHeight;
    int border = 10;
    int x = border;
    int y = border;
    int c = 1;
    
    for (NSDictionary *i in images) {
        if (c > 3) {
            y += imageHeight;
            x = border;
            c = 1;
            scrollViewHeight += imageHeight;
        }
        NSURL *url = [NSURL URLWithString: [i valueForKey:@"url_200x200"]];
        CGRect frame = CGRectMake(x, y, imageWidth - border, imageHeight - border);
        
        AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        asyncImage.withBorder = TRUE;
        
        asyncImage.tag = 999;
        [asyncImage loadImageFromURL:url];
        [self.view addSubview:asyncImage];
        x += imageWidth;
        c++;
    }
    
    [scrollView setContentSize:CGSizeMake(300, scrollViewHeight + border)];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	
//    UITouch *touch = [touches anyObject];
//	
//    if ([touch view] == UIImageView)
//    {
//		NSLog(@"TOUCH!!");
//    }
//}

-(IBAction)viewImage:(id) sender
{
    CollectionViewController *viewController	=	[[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:[NSBundle mainBundle]];
	
//    NSURL *url = [NSURL URLWithString: [image valueForKey:@"url_200x200"]];
//    CGRect frame = CGRectMake(x, y, imageWidth - border, imageHeight - border);
//    
//    AsyncImageView* asyncImage = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
//    asyncImage.withBorder = TRUE;
//    
//    asyncImage.tag = 999;
//    [asyncImage loadImageFromURL:url];
//    [self.view addSubview:asyncImage];
    

    
	[self.navigationController pushViewController:viewController animated:YES];
    
	[viewController release];
	viewController = nil;
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
    
    [self loadImages];
    // Do any additional setup after loading the view from its nib.
     NSLog(@"Artist Id : %@", artist_id);
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
