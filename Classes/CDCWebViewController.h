//
//  CDCWebViewController.h
//  CelestialGlory
//
//  Created by Joseph Cheek on 11/5/12.
//  Copyright (c) 2012 CheekDotCom Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCWebViewController : UIViewController <UIWebViewDelegate> {
	
	IBOutlet UIWebView *CDCWebView;
	NSURL *url;
	NSString *uniqueIdentifier;
    
}

@property (nonatomic, strong) IBOutlet UIWebView *CDCWebView;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *uniqueIdentifier;

@end
