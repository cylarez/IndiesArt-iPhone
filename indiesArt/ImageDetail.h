//
//  ImageDetail.h
//  indiesArt
//
//  Created by sylvain NICOLLE on 11-04-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "asyncImageView.h"


@interface ImageDetail : AsyncImageView {
    
    UINavigationController *navigationController;
    UILabel *imageLabel;

}

@property(nonatomic, retain) UINavigationController *navigationController;
@property(nonatomic, retain) UILabel *imageLabel;

@end
