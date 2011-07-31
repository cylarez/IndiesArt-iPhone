//
//  GalleryViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indiesArtAppDelegate.h"
@class indiesArtAppDelegate;
#import "TwitterRushViewController.h"

@interface GalleryViewController : UIViewController < FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
    indiesArtAppDelegate* appDelegate;
    UIButton *fbButton;
    Facebook *facebook;
    MBProgressHUD *HUD;
    NSDictionary* artist;
}

@property (nonatomic, copy) NSDictionary *artist;
@property (nonatomic, retain) Facebook *facebook;

- (void)imageSaved;
- (void)shareImageFacebook;
- (void)shareImageTwitter;
- (void)fbDidLogin;
- (void)launchFacebook;

@end
