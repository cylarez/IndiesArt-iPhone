//
//  DiscoverViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DiscoverViewController.h"


@implementation DiscoverViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[[UIApplication sharedApplication] delegate] retain];

    [self reloadData];
}

- (IBAction)reloadData
{
    NSString *url = [NSString stringWithFormat:@"%@/mobile/discover", INDIE_URL];
    NSDictionary *data = [appDelegate downloadData: url];
    images = [data valueForKey:@"images"]; 
    artist =  data;
    [self loadImages];
}

@end
