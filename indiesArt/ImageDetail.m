//
//  ImageDetail.m
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageDetail.h"


@implementation ImageDetail

@synthesize navigationController;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
    //UITouch *touch = [touches anyObject];
	
    NSLog(@"TOUCH!!");   
    
    [navigationController setNavigationBarHidden:(navigationController.navigationBarHidden ? NO : YES) animated:YES];
    
}


@end