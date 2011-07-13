//
//  indiesArtAppDelegate.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "MBProgressHUD.h"
#import "ArtistDetailViewController.h"



@interface indiesArtAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
    NSDictionary *feed;
    Facebook *facebook;
    NSDictionary *discoverData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) NSDictionary *feed;
@property (nonatomic, retain) NSDictionary *discoverData;
@property (nonatomic, retain) Facebook *facebook;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (NSDictionary*)downloadData:(NSString*)url;
- (NSDictionary*)getDiscoverData;

@end
