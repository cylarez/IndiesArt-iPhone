//
//  CollectionViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CollectionViewController.h"


@implementation CollectionViewController

@synthesize scrollView, mainImageUrl, currentImage, images, artist_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSDictionary*)getArtist
{
    return [currentImage.imageData valueForKey:@"artist"];
}

- (NSString*)getUrl
{
    return [currentImage.imageData valueForKey:@"url_page"];
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
    int size = [images count] * 320;
    
    NSLog(@"Count %d", [images count]);
    
    
    
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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Available Actions"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil
													otherButtonTitles:@"Use as Wallpaper", @"Share on Facebook", @"Share on Twitter", nil];
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
        [self shareImageFacebook];
    }
    if (buttonIndex == 2) {
        [self shareImageTwitter];
    }
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
    
    NSMutableDictionary *image = [images objectAtIndex:index];

    
    NSString *url = [image valueForKey:@"url"];
    ImageDetail *asyncImage;
    
    if (! [image valueForKey:@"asyncImage"]) {
        asyncImage = [[[ImageDetail alloc] initWithFrame:frame] autorelease];
        
        // Insert loading 
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(135,215,50,50)];
        activityView.activityIndicatorViewStyle =  UIActivityIndicatorViewStyleWhiteLarge;
        [activityView startAnimating];    
        [asyncImage addSubview:activityView]; 
        [activityView release];
        asyncImage.userInteractionEnabled = TRUE;
        asyncImage.multipleTouchEnabled = TRUE;
        asyncImage.navigationController = self.navigationController;
        asyncImage.controller = self;
        asyncImage.imageData = image;
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
    
    if (nextImageIndex < [images count]) {
         [self loadImage: nextImageIndex recursive:FALSE];
    }
    if (prevImageIndex >= 0) {
        [self loadImage: prevImageIndex recursive:FALSE];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    
//    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
//        [UIView beginAnimations:@"View Flip" context:nil];
//        [UIView setAnimationDuration:0.5f];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        self.view.transform = CGAffineTransformIdentity;
//        self.view.transform =
//        CGAffineTransformMakeRotation(M_PI * (90) / 180.0);
//        self.view.bounds = CGRectMake(0.0f, 0.0f, 480.0f, 320.0f);
//        self.view.center = CGPointMake(160.0f, 240.0f);
//        [UIView commitAnimations];
//    }
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	//we want to support all orientations
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"Rotate Go!");
}

@end
