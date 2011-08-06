//
//  RotatingTabBarController.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-08-04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RotatingTabBarController.h"

@implementation RotatingTabBarController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Always returning YES means the view will rotate to accomodate any orientation.
    return NO;
}

@end