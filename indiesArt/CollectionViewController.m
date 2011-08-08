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

- (void)setScrollViewSize
{
    BOOL landscape = FALSE;
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        landscape = TRUE;
    }
    int _size = landscape ? 480 : 320;
    int size = [images count] * _size;
    
    NSLog(@"Called index %i", called_index);
    NSLog(@"Called size %i", _size);
    
    // Set the scroller to the appropriate image
    [scrollView setContentOffset:CGPointMake(called_index * _size, 0) animated:NO];
	[scrollView setContentSize:CGSizeMake(size, [scrollView bounds].size.height)];
}

- (void)changeOrientation
{
    BOOL landscape = FALSE;
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        landscape = TRUE;
    }
    int _h = 480;
    int _w = 320;
    int i = 0;
    
    for (NSMutableDictionary *image in images) {
        if ([image valueForKey:@"asyncImage"]) {
            ImageDetail *asyncImage =  [image valueForKey:@"asyncImage"];
            asyncImage.frame = CGRectMake(i * (landscape ? _h : _w), 0, landscape ? _h :_w, landscape ? _w : _h);
            
            //            [UIView beginAnimations : @"Redraw Image" context:nil];
            //            [UIView setAnimationDuration:1];
            //            [UIView setAnimationBeginsFromCurrentState:FALSE];
            //            
            //            CGRect frame = asyncImage.frame;
            //            frame.size.height = landscape ? _w : _h;
            //            frame.size.width = landscape ? _h : _w;
            //            frame.origin.x = i * (landscape ? _h : _w);
            //            asyncImage.frame = frame;
            
            [UIView commitAnimations];
            
            
            
            
            asyncImage.imageInfoView.frame = CGRectMake(0, landscape ? 200 : 360, landscape ? _h : _w, 120);
            asyncImage.imageLabel.frame = CGRectMake(0, 0, landscape ? _h : _w, 110);
        }
        i++;
    }
    [self setScrollViewSize];
}

- (void)setupPage:(int)index
{

    called_index = index;
	scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
    // Call the image
    [self loadImage:index recursive:TRUE];
    
    [self setScrollViewSize];

    // Add button
    UIBarButtonItem *button = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Actions"
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
													otherButtonTitles:@"Use as Wallpaper", @"Share via Facebook", @"Share via Twitter", @"Share via Email", nil];
	[actionSheet showInView:[self view]];
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
    if (buttonIndex == 3) {
        [self shareImageEmail];
    }
}

- (void)loadImage:(int)index  recursive:(BOOL) recursive;
{
    BOOL landscape = FALSE;
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        landscape = TRUE;
    }
    int _h = 480;
    int _w = 320;
    
    int height = landscape ? _w : _h;
    int width = landscape ? _h : _w;
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
        asyncImage.userInteractionEnabled = TRUE;
        asyncImage.multipleTouchEnabled = TRUE;
        [asyncImage loadImageFromURL:url];
        [image setValue:asyncImage forKey:@"asyncImage"];
        
    } else {
        asyncImage =  [image valueForKey:@"asyncImage"];
    }
    asyncImage.navigationController = self.navigationController;
    asyncImage.controller = self;
    asyncImage.imageData = image;
    
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
    
    called_index = page;
    [self loadImage:page recursive:TRUE];
    
}




#pragma - Basic Method

- (void) viewWillAppear:(BOOL)animated
{
    [self changeOrientation];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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


- (void)viewDidUnload
{
    [super viewDidUnload];
    [[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	//we want to support all orientations
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self changeOrientation];
}

@end
