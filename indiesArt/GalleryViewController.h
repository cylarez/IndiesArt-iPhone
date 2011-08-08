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
#import <MessageUI/MessageUI.h>

@interface GalleryViewController : UIViewController < FBRequestDelegate, FBDialogDelegate, FBSessionDelegate, MFMailComposeViewControllerDelegate> {
    indiesArtAppDelegate* appDelegate;
    UIButton *fbButton;
    UIButton *twButton;
    UIButton *emailButton;
    Facebook *facebook;
    MBProgressHUD *HUD;
    NSDictionary* artist;
}

@property (nonatomic, copy) NSDictionary *artist;
@property (nonatomic, retain) Facebook *facebook;

- (void)imageSaved;
- (IBAction)shareImageTwitter;
- (IBAction)shareImageFacebook;
- (IBAction)shareImageEmail;

- (void)fbDidLogin;
- (void)launchFacebook;

@end
