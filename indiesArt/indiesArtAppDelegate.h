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
#import "MKBitlyHelper.h"
#import "asyncImageView.h"

#define INDIE_URL               @""
#define ARTIST_URL              @""
#define APP_ID                  @""
#define kOAuthConsumerKey       @""   
#define kOAuthConsumerSecret    @""
#define BIT_LOGIN               @""
#define BIT_KEY                 @""



@interface indiesArtAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
    NSDictionary *feed;
    NSString *about;
    Facebook *facebook;
    NSDictionary *discoverData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *about;
@property (nonatomic, retain) NSDictionary *feed;
@property (nonatomic, retain) NSDictionary *discoverData;
@property (nonatomic, retain) Facebook *facebook;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (NSString *)stringWithUrl:(NSString *)url;
- (NSDictionary*)downloadData:(NSString*)url;
- (NSDictionary*)getFeedData;
- (NSDictionary*)getDiscoverData;
- (NSString*)getShortUrl:(NSString*)url;

@end
