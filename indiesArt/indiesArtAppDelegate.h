//
//  indiesArtAppDelegate.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "ArtistDetailViewController.h"

#define INDIE_URL               @"http://cylarez:expression@dev.indiesart.com"
#define ARTIST_URL              @"mobile/artist"
#define APP_ID                  @"139707482707461"
#define kOAuthConsumerKey		@"5HdyAAORjW6Yyzza2W8PWA"	    
#define kOAuthConsumerSecret	@"t8mtNrE7ZePd5xkgIQ4F7iezPbjxSwcbtUrWGqGZk"
#define BIT_LOGIN               @"cylarez"
#define BIT_KEY                 @"R_2bbf1d1814692eec736d83f7d756c3fb"


@interface indiesArtAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
    NSDictionary *feed;
    Facebook *facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) NSDictionary *feed;
@property (nonatomic, retain) Facebook *facebook;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (NSDictionary*)downloadData:(NSString*)url;

@end
