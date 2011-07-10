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
    NSDictionary *image;
    UIButton *fbButton;
    UIView *imageInfoView;
}

@property(nonatomic, retain) UINavigationController *navigationController;
@property(nonatomic, retain) UILabel *imageLabel;
@property(nonatomic, retain) NSDictionary *image;
@property(nonatomic, retain) UIButton *fbButton;
@property(nonatomic, retain) UIView *imageInfoView;

@end
