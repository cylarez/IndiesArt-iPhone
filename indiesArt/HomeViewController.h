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
#import "ArtistDetailViewController.h"

@interface HomeViewController : UITableViewController <UIScrollViewDelegate> {
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
	indiesArtAppDelegate* appDelegate;
    BOOL pageControlIsChangingPage;
    
    NSArray* artists;
    NSArray* submissions;
}

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;

@property (nonatomic, retain) NSArray* artists;
@property (nonatomic, retain) NSArray* submissions;

- (IBAction)changePage:(id)sender;
- (void)setupPage;
@end
