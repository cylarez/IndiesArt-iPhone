//
//  AboutViewController.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indiesArtAppDelegate.h"

@interface AboutViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;

@end