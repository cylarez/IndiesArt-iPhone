//
//  indiesArtAppDelegate.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define INDIE_URL @"http://dev.indiesart.com"
#define ARTIST_URL  @"mobile/artist"

@interface indiesArtAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    NSDictionary *feed;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) NSDictionary *feed;

- (NSDictionary*)downloadData:(NSString*)url;

@end
