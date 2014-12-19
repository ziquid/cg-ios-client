//
//  ViewController.m
//  webtest2
//
//  Created by Joseph Cheek on 11/5/12.
//  Copyright (c) 2012 Joseph Cheek. All rights reserved.
//

#import "CDCWebViewController.h"
#import "MKStoreManager.h"

@implementation CDCWebViewController

@synthesize CDCWebView, url, uniqueIdentifier;

- (void)viewDidLoad
{
    //    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    CGRect rect = self.CDCWebView.frame;
//    rect.size.height = 480;
    
    self.CDCWebView.delegate = self;
    
    UIDevice *device = [UIDevice currentDevice];
	self.uniqueIdentifier = [[device identifierForVendor] UUIDString];
    
    NSString *deviceType = @"iPhone";
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 30200
    if (device.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        deviceType = @"iPad";
    }
#endif
    
#ifdef DEBUG
    NSString *urlCore = @"http://cg.dev.game.ziquid.com/celestial_glory/bounce/";
#else
    NSString *urlCore = @"http://cg.game.ziquid.com/celestial_glory/bounce/";
#endif
    
	NSString *urlAddress = [urlCore stringByAppendingString:self.uniqueIdentifier];
	
    NSString *normalAgent = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *versionStr = [NSString stringWithFormat:@"%@/%@/%@", deviceType,
                            [appInfo objectForKey:@"CFBundleShortVersionString"],
                            [appInfo objectForKey:@"CFBundleVersion"]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *authKey = [defaults stringForKey:@"authKey"];
    NSLog(@"stored authKey is %@", authKey);
    
    if ([authKey length] == 0) { // no authKey stored
        authKey = [self GetUUID];
        [defaults setValue:authKey forKey:@"authKey"];
    }
    
    NSString* secretAgent = [NSString stringWithFormat:@"%@ (com.ziquid.celestialglory; %@; authKey=%@)",
                             normalAgent, versionStr, authKey];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:secretAgent, @"UserAgent", nil];
    [defaults registerDefaults:dictionary];
    [defaults synchronize];
    
    NSLog(@"new useragent default: %@",[defaults objectForKey:@"UserAgent"]);
    
	//Create a URL object.
	NSURL *defaultURL = [NSURL URLWithString:urlAddress];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:defaultURL];
    
    [CDCWebView loadRequest:requestObj];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)CDCWebView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
	self.url = [request URL];
	NSString *urlString = [self.url absoluteString];
    NSLog(@"visiting %@", urlString);
    
	NSRange match10 = [urlString rangeOfString: @"https://www.paypal.com/buy/luck/10"];
	
	if (match10.location == 0) {
		
		NSLog(@"Let's go buy some Luck!");
		[[MKStoreManager sharedManager] buyFeature:kConsumableFeatureAId forProduct:0];
		return NO;
		
	}
	
	NSRange match35 = [urlString rangeOfString: @"https://www.paypal.com/buy/luck/35"];
	
	if (match35.location == 0) {
		
		NSLog(@"Let's go buy some Luck!");
		[[MKStoreManager sharedManager] buyFeature:kConsumableFeatureBId forProduct:1];
		return NO;
		
	}
	
	NSRange match150 = [urlString rangeOfString: @"https://www.paypal.com/buy/luck/150"];
	
	if (match150.location == 0) {
		
		NSLog(@"Let's go buy some Luck!");
		[[MKStoreManager sharedManager] buyFeature:kConsumableFeatureCId forProduct:2];
		return NO;
		
	}
    
    NSRange match320 = [urlString rangeOfString: @"https://www.paypal.com/buy/luck/320"];
	
	if (match320.location == 0) {
		
		NSLog(@"Let's go buy some Luck!");
		[[MKStoreManager sharedManager] buyFeature:kConsumableFeatureDId forProduct:3];
		return NO;
		
	}
    
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		
		if ([urlString isEqualToString:@"http://cg.game.ziquid.com/"] ||
            [urlString isEqualToString:@"http://forum.ziquid.com/"] ||
            [urlString isEqualToString:@"http://cg.dev.game.ziquid.com/"] ||
            [urlString isEqualToString:@"http://forum.dev.ziquid.com/"]) {
			
			NSLog(@"Holy cow, Batman!  We're going home!");
			
			// get our unique iPhone ID
			UIDevice *device = [UIDevice currentDevice];
			uniqueIdentifier = [[device identifierForVendor] UUIDString];

#ifdef DEBUG
			NSString *urlCore = @"http://cg.dev.game.ziquid.com/celestial_glory/home/";
#else
			NSString *urlCore = @"http://cg.game.ziquid.com/celestial_glory/home/";
#endif
			NSString *urlAddress = [urlCore stringByAppendingString:uniqueIdentifier];
			
			//Create a URL object.
			NSURL *defaultURL = [NSURL URLWithString:urlAddress];
			
			//URL Requst Object
			NSURLRequest *requestObj = [NSURLRequest requestWithURL:defaultURL];
			
			//Load the request in the UIWebView.
			[CDCWebView loadRequest:requestObj];
			
		}
		
	}
	
    return YES;
	
}

- (NSString *)GetUUID
{
    
    NSString * result;
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    result = [NSString stringWithFormat:@"%@", string];
    assert(result != nil);
    
    NSLog(@"%@",result);
    return result;
    
}


@end
