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
@class indiesArtAppDelegate;

@interface CollectionViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
    IBOutlet UIScrollView *scrollView;
    indiesArtAppDelegate* appDelegate;
    NSString *mainImageUrl;
    IBOutlet ImageDetail *currentImage;
    UIButton *fbButton;
    Facebook *facebook;
    NSArray *images;
    NSString *artist_id;
    MBProgressHUD *HUD;
}


@property(nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain)  NSString *mainImageUrl;
@property (nonatomic, retain) ImageDetail *currentImage;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain)  NSString *artist_id;

- (void)setupPage:(int)index;
- (void)loadImage:(int)index recursive:(BOOL) recursive;
- (void)imageSaved;
- (void)shareImageFacebook;
- (void)shareImageTwitter;
- (void)fbDidLogin;
- (void)launchFacebook;

@end
