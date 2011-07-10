//
//  CollectionViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CollectionViewController.h"


@implementation CollectionViewController

@synthesize scrollView, mainImageUrl, currentImage, artist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupPage:(int)index
{

	scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
    // Call the image
    [self loadImage:index recursive:TRUE];
    int size = [[artist valueForKey:@"images"] count] * 320;
    
    // Set the scroller to the appropriate image
    [scrollView setContentOffset:CGPointMake(index * 320, 0) animated:NO];
    
	[scrollView setContentSize:CGSizeMake(size, [scrollView bounds].size.height)];
    
    // Add button
    UIBarButtonItem *button = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Options"
								   style:UIBarButtonItemStyleBordered
								   target:self
                                    action:@selector(viewMenu:)] autorelease];
	self.navigationItem.rightBarButtonItem = button;
}

-(void)viewMenu:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"A Message To Display"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil
													otherButtonTitles:@"Use as Wallpaper", @"Share", nil];
	[actionSheet showInView:[[self.navigationController view] window]];
    [actionSheet release];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    NSLog(@"Button index %i", buttonIndex);
    
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(currentImage.imageView.image, nil, nil, nil);
        [self imageSaved];
    }
    if (buttonIndex == 1) {
        [self shareImage];
    }
}

- (void)shareImage
{
    NSString *url = [NSString stringWithFormat:@"%@%@", @"http://www.indiesart.com", [currentImage.image valueForKey:@"url_page"]];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   APP_ID, @"app_id",
                                   url, @"link",
                                   @"I love this image found on indiesArt!",  @"message",
                                   nil];

    [appDelegate.facebook dialog:@"feed" andParams:params andDelegate:self];
}

- (void)imageSaved
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"The Image has been saved" message:@"Please go your iPhone Settings or in the Photos Manager to change your Wallpaper" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert show];
}

- (void)loadImage:(int)index  recursive:(BOOL) recursive;
{

    int height = 480;
    int width = 320;
    CGRect frame;
    frame.size.height = height;
    frame.size.width = width;
    frame.origin.x = width * index;
    frame.origin.y = 0;
    
    
    NSArray *images = [artist valueForKey:@"images"];
    
    NSDictionary *image = [images objectAtIndex:index];
    
    NSString *url = [image valueForKey:@"url"];
    ImageDetail *asyncImage;
    
    if (! [image valueForKey:@"asyncImage"]) {
        asyncImage = [[[ImageDetail alloc] initWithFrame:frame] autorelease];
        
        asyncImage.userInteractionEnabled = TRUE;
        asyncImage.multipleTouchEnabled = TRUE;
        asyncImage.navigationController = self.navigationController;
        
        // Create image info
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        
        myLabel.textColor = [UIColor whiteColor];
        myLabel.lineBreakMode = UILineBreakModeWordWrap;
        myLabel.numberOfLines = 2;
        myLabel.backgroundColor = [UIColor blackColor];
        myLabel.alpha = 0.7;
        myLabel.text = [NSString stringWithFormat:@"%@ %@", [artist valueForKey:@"name"], [image valueForKey:@"name"]];
        
        // Create FB button
        fbButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [fbButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchDown];
        fbButton.frame = CGRectMake(5, 60, 87, 30);
        [fbButton setImage:[UIImage imageNamed:@"facebook_button.png"] forState:UIControlStateNormal];
        
        

        asyncImage.fbButton = fbButton;
        asyncImage.image = image;
        asyncImage.imageLabel = myLabel;
        [asyncImage loadImageFromURL:url];
        
        [image setValue:asyncImage forKey:@"asyncImage"];
        
    } else {
        asyncImage =  [image valueForKey:@"asyncImage"];
    }
    
    [scrollView addSubview:asyncImage];
    
    if (! recursive) {
        return;
    }
    
    self.currentImage = asyncImage;
    
    int nextImageIndex = index + 1;
    int prevImageIndex = index - 1;
    
    if (nextImageIndex < [[artist valueForKey:@"images"] count]) {
         [self loadImage: nextImageIndex recursive:FALSE];
    }
    if (prevImageIndex >= 0) {
        [self loadImage: prevImageIndex recursive:FALSE];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    
    [self loadImage:page recursive:TRUE];
    
}




#pragma - Basic Method

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
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
    appDelegate = [[[UIApplication sharedApplication] delegate] retain];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
