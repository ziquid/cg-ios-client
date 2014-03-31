//
//  SKProduct+LocalizedPrice.h
//  StLouis
//
//  Created by Joseph Cheek on 1/24/11.
//  Copyright 2011 CheekDotCom Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface SKProduct (LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end