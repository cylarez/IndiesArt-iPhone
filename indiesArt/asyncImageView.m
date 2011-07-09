
//
//  AsyncImageView.m
//  Postcard
//
//  Created by markj on 2/18/09.
//  Copyright 2009 Mark Johnson. You have permission to copy parts of this code into your own projects for any use.
//  www.markj.net
//

#import "AsyncImageView.h"


// This class demonstrates how the URL loading system can be used to make a UIView subclass
// that can download and display an image asynchronously so that the app doesn't block or freeze
// while the image is downloading. It works fine in a UITableView or other cases where there
// are multiple images being downloaded and displayed all at the same time. 

@implementation AsyncImageView

@synthesize imageView, imageData;

- (void)dealloc {
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release]; 
    [super dealloc];
}

- (void)loadImageFromURL:(NSString*)url {
    
    // Deactivate touch 
    self.userInteractionEnabled = TRUE;
    
	if (connection!=nil) { [connection release]; } //in case we are downloading a 2nd image
	if (data!=nil) { [data release]; }
	
    NSURL *_url = [NSURL URLWithString: url];
	NSURLRequest* request = [NSURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object
	//TODO error handling, what if connection is nil?
    
    
    UIImage *bg = [UIImage imageNamed:@"bg-default-50.png"];
    
    imageView = [[[UIImageView alloc] initWithImage:bg] autorelease];
    
    //[self addSubview:imageView];
}

- (int) getSpinnerStyle
{
    return UIActivityIndicatorViewStyleGray;
}


//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	//so self data now has the complete image 
	[connection release];
	connection=nil;
	if ([[self subviews] count] > 0) {
		//then this must be another image, the old one is still in subviews
		//[[[self subviews] objectAtIndex:0] removeFromSuperview]; //so remove it (releases it also)
	}
	
	//make an image view for the image
	imageView = [[[UIImageView alloc] initWithImage:[UIImage imageWithData:data]] autorelease];
	
    //make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth || UIViewAutoresizingFlexibleHeight );
    
    [self displayImage];

	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;
}

//just in case you want to get the image directly, here it is in subviews
- (UIImage*) image {
	UIImageView* iv = [[self subviews] objectAtIndex:0];
	return [iv image];
}

- (void)displayImage
{
    imageView.alpha = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.alpha = 1;
    [UIView commitAnimations];
    
	[self addSubview:imageView];
	imageView.frame = self.bounds;
}

@end