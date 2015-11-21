//
//  FQAHReachability.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface FQAHReachability : NSObject
@property (nonatomic, unsafe_unretained) BOOL isReachable;
@property (nonatomic, unsafe_unretained) BOOL isReachableWifi;
//@property (nonatomic, strong) NSString *wifiName;

+ (FQAHReachability *)sharedInstance;
- (void)startMonitoringInternetStates;

@end
