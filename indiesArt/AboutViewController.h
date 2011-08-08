//
//  AboutViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indiesArtAppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    IBOutlet UITextView *textView;
    indiesArtAppDelegate* appDelegate;
    MBProgressHUD *HUD;
    IBOutlet UIScrollView *scrollView;
}

@property(nonatomic, retain) IBOutlet UITextView *textView;

@end
