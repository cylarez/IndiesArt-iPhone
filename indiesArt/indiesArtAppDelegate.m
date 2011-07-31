//
//  indiesArtAppDelegate.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "indiesArtAppDelegate.h"
#import "JSON/SBJSON.h"


@implementation indiesArtAppDelegate


@synthesize window=_window, feed, discoverData, about, facebook;

@synthesize tabBarController=_tabBarController;


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [facebook handleOpenURL:url];
}

- (NSDictionary*)getFeedData
{
    return [self downloadData:[INDIE_URL stringByAppendingString: @"/mobile/main"]];
}

- (NSDictionary*)getDiscoverData
{
    return [self downloadData:[INDIE_URL stringByAppendingString: @"/mobile/discover"]];
}

- (NSString*)getShortUrl:(NSString*)url
{
    MKBitlyHelper *bitlyHelper = [[MKBitlyHelper alloc] initWithLoginName:BIT_LOGIN andAPIKey:BIT_KEY];
    NSString *shortUrl = [bitlyHelper shortenURL:url];
    [bitlyHelper release];
    return shortUrl;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarHidden:FALSE];
    
    // Download indiesArt data
    self.feed = [self getFeedData];
    self.discoverData = [self getDiscoverData];
    self.about = [self stringWithUrl:@"http://cylarez:expression@dev.indiesart.com/mobile/about"];
    facebook = [[Facebook alloc] initWithAppId:APP_ID];
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;

    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [feed release];
    [discoverData release];
    [facebook release];
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

- (NSString *)stringWithUrl:(NSString *)url
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
												cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
											timeoutInterval:30];
	NSURLResponse *response;
	NSError *error;
	
	// Make synchronous request
	NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest
											returningResponse:&response
														error:&error];
	
 	// Construct a String around the Data from the response
    NSString *str = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	
    [str autorelease];
    return str;
}

- (id)objectWithUrl:(NSString *)url
{	
	SBJsonParser *parser = [SBJsonParser new];
    [parser autorelease];
	NSString *jsonString = [self stringWithUrl:url];
    
	return [parser objectWithString:jsonString];
}

- (NSDictionary *)downloadData:(NSString*)url 
{
	id result = [self objectWithUrl:url];
	NSDictionary *f = (NSDictionary *)result;
    
	return f;
}



@end
