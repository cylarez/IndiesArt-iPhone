//
//  HomeViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IndiesArtViewController.h"

#import "asyncImageView.h"
#import "ImageSlide.h"
#import "ArtistDetailViewController.h"  

@interface HomeViewController : IndiesArtViewController <UIScrollViewDelegate> {
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
    BOOL pageControlIsChangingPage;
    NSArray* slides;
    MBProgressHUD *HUD;
}

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;
@property (nonatomic, retain) NSArray* slides;

- (IBAction)changePage:(id)sender;
- (IBAction)reloadData:(id)sender;
- (void)setupPage;

@end
