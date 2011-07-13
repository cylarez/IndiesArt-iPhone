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


@synthesize window=_window, feed, discoverData, facebook;

@synthesize tabBarController=_tabBarController;


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [facebook handleOpenURL:url];
}

- (NSDictionary*)getDiscoverData
{
    return [self downloadData:[INDIE_URL stringByAppendingString: @"/mobile/discover"]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;

    [self.window makeKeyAndVisible];
    
    // Download indiesArt data
    self.feed = [self downloadData:[INDIE_URL stringByAppendingString: @"/mobile/main"]];
    self.discoverData = [self getDiscoverData];
    
    facebook = [[Facebook alloc] initWithAppId:APP_ID];
    
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

- (NSString *)stringWithUrl:(NSURL *)url
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
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

- (id)objectWithUrl:(NSURL *)url
{	
	SBJsonParser *parser = [SBJsonParser new];
    [parser autorelease];
	NSString *jsonString = [self stringWithUrl:url];
    
	return [parser objectWithString:jsonString];
}

- (NSDictionary *)downloadData:(NSString*)url 
{
	id result = [self objectWithUrl:[NSURL URLWithString:url]];
	NSDictionary *f = (NSDictionary *)result;
    
	return f;
}



@end
