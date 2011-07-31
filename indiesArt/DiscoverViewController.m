//
//  DiscoverViewController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-07-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DiscoverViewController.h"


@implementation DiscoverViewController


- (void)_reloadData
{
    NSDictionary *data = autoLoad ? appDelegate.discoverData : [appDelegate getDiscoverData];
    autoLoad = FALSE;
    self.images = [data valueForKey:@"images"]; 
    artist =  data;
}



@end
