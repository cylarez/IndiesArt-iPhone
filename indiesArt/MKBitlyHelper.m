//
//  MKBitlyHelper.m
//  BitlyDemo
//
//  Created by Mugunth Kumar on 25-Jul-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//  http://mugunthkumar.com
//

#import "MKBitlyHelper.h"
#import "JSON.h"

@implementation MKBitlyHelper

static NSString *BITLYAPIURL = @"http://api.bit.ly/%@?version=2.0.1&login=%@&apiKey=%@&";

-(MKBitlyHelper*) initWithLoginName: (NSString*) f_loginName andAPIKey: (NSString*) f_apiKey {

	loginName = [f_loginName copy];
	apiKey = [f_apiKey copy];
	
	return self;
}

- (NSString*) shortenURL: (NSString*) f_longURL {
	
	NSString *urlWithoutParams = [NSString stringWithFormat:BITLYAPIURL, @"shorten", loginName, apiKey];	
	CFStringRef encodedParamCF = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
															 (CFStringRef) f_longURL, 
															 nil, (CFStringRef) @"&+", kCFStringEncodingUTF8); 
	f_longURL = (NSString*)encodedParamCF;
    

	NSString *parameters = [NSString stringWithFormat:@"longUrl=%@", [f_longURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
	NSString *finalURL = [urlWithoutParams stringByAppendingString:parameters];
	
	NSURL *url = [NSURL URLWithString:finalURL];
	
	NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
	
	NSHTTPURLResponse* urlResponse = nil;  
	NSError *error = [[[NSError alloc] init] autorelease];  
	
	NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];	
    
    [req release];
    
    NSString *shortURL = nil;
    
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
	{
		SBJSON *jsonParser = [SBJSON new];
		NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		NSDictionary *dict = (NSDictionary*)[jsonParser objectWithString:jsonString];
		[jsonString release];
		[jsonParser release];
        
		
		NSString *statusCode = [dict objectForKey:@"statusCode"];
		
		if([statusCode isEqualToString:@"OK"])
		{
			// retrieve shortURL from results
			//NSLog([dict description]);
			shortURL = [[[dict objectForKey:@"results"] 
								   objectForKey:f_longURL] 
								  objectForKey:@"shortUrl"];
		}
	}

    CFRelease (encodedParamCF);
    
    return shortURL;
}

- (NSString*) expandURL: (NSString*) f_shortURL {
	
	NSString *urlWithoutParams = [NSString stringWithFormat:BITLYAPIURL, @"expand", loginName, apiKey];
	NSString *parameters = [NSString stringWithFormat:@"shortUrl=%@", [f_shortURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSString *finalURL = [urlWithoutParams stringByAppendingString:parameters];
	
	NSURL *url = [NSURL URLWithString:finalURL];
	
	NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
	
	NSHTTPURLResponse* urlResponse = nil;  
	NSError *error = [[[NSError alloc] init] autorelease];  
	
	NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];	
	
    [req release];
    
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
	{
		SBJSON *jsonParser = [SBJSON new];
		NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		NSDictionary *dict = (NSDictionary*)[jsonParser objectWithString:jsonString];
		[jsonString release];
		[jsonParser release];
		
		NSString *statusCode = [dict objectForKey:@"statusCode"];
		
		if([statusCode isEqualToString:@"OK"])
		{
			// retrieve shortURL from results
			NSString *shortHash = nil;
			NSRange range = [f_shortURL rangeOfString:@"/" options:NSBackwardsSearch];
			if(range.location != NSNotFound) {
				
				shortHash = [f_shortURL substringFromIndex:range.location+1];
			}
			
			//NSLog([dict description]);
			NSString *longURL = [[[dict objectForKey:@"results"] 
								   objectForKey:shortHash] 
								  objectForKey:@"longUrl"];
            [urlResponse release];
			return longURL;
		}
		
	}
    [urlResponse release];
	return nil;
}
@end
