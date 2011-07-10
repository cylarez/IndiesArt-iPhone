//
//  CollectionViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDetail.h"
@class ImageDetail;
#import "indiesArtAppDelegate.h"

@interface CollectionViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, FBDialogDelegate> {
    IBOutlet UIScrollView *scrollView;
    indiesArtAppDelegate* appDelegate;
    NSDictionary *artist;
    NSString *mainImageUrl;
    IBOutlet ImageDetail *currentImage;
    UIButton *fbButton;
}


@property(nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain)  NSDictionary *artist;
@property (nonatomic, retain)  NSString *mainImageUrl;
@property (nonatomic, retain) ImageDetail *currentImage;

- (void)setupPage:(int)index;
- (void)loadImage:(int)index recursive:(BOOL) recursive;
- (void)imageSaved;
- (void)shareImage;


@end
