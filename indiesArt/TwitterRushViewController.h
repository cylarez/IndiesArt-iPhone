//
//  TwitterRushViewController.h
//  TwitterRush

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"
#import "indiesArtAppDelegate.h"

@class SA_OAuthTwitterEngine;

@interface TwitterRushViewController : UIViewController <UITextFieldDelegate, SA_OAuthTwitterControllerDelegate>
{ 
	IBOutlet UITextField *tweetTextField;
	IBOutlet UILabel *frameTweet;
	SA_OAuthTwitterEngine				*_engine;
    MBProgressHUD *HUD;
}

@property(nonatomic, retain) IBOutlet UITextField *tweetTextField;
@property(nonatomic, retain) IBOutlet UILabel *frameTweet;

-(IBAction)updateTwitter:(id)sender; 

@end

