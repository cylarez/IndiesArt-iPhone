//
//  HomeViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indiesArtAppDelegate.h"
#import "asyncImageView.h"
#import "ImageSlide.h"
#import "ArtistDetailViewController.h"

@interface HomeViewController : UITableViewController <UIScrollViewDelegate> {
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
    BOOL pageControlIsChangingPage;
    
	indiesArtAppDelegate* appDelegate;
    
    NSArray* artists;
    NSArray* submissions;
    NSArray* slides;
}

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;

@property (nonatomic, retain) NSArray* artists;
@property (nonatomic, retain) NSArray* submissions;
@property (nonatomic, retain) NSArray* slides;

- (IBAction)changePage:(id)sender;
- (void)setupPage;

@end
