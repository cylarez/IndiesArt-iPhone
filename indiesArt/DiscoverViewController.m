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
    autoLoad = TRUE;
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
}

- (void)_reloadData
{
    NSDictionary *data = autoLoad ? appDelegate.discoverData : [appDelegate getDiscoverData];
    autoLoad = FALSE;
    self.images = [data valueForKey:@"images"]; 
    artist =  data;
    
}

- (IBAction)reloadData
{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading";
        
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

        [self _reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadImages];
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        });
    });
    
    
}



@end
