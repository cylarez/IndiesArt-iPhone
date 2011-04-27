//
//  CollectionViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDetail.h"
#import "indiesArtAppDelegate.h"

@interface CollectionViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl* pageControl;
    indiesArtAppDelegate* appDelegate;
    
    NSString *mainImageUrl;
    NSArray *images;
    ImageDetail *currentImage;
}


@property(nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;
@property (nonatomic, copy)  NSArray *images;
@property (nonatomic, retain)  NSString *mainImageUrl;
@property (nonatomic, retain) ImageDetail *currentImage;

- (void)setupPage:(int)index;
- (void)loadImage:(int)index recursive:(BOOL) recursive;
- (void)imageSaved;

@end
