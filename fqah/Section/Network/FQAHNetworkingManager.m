//
//  FQAHNetworkingManager.m
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "FQAHNetworkingManager.h"

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * API URL 调用参数
 */

#define BASE_URL_Recruit @"recruit"
#define BASE_URL_Photo   @"photo"


NSString *const kAPITopTypee = FQAH_API BASE_URL_Recruit @"/getTypes.do?";
NSString *const kAPIDynamic  = FQAH_API BASE_URL_Photo @"/getPhotos.do";
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FQAHNetworkingManager


#pragma mark - public interface

///1.
- (void)getTopTypesWithParameters:(NSDictionary *)parameters completedHandler:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock{
    [self POST:kAPITopTypee params:parameters memoryCache:NO diskCache:YES completed:completed  isNotReachable:notRBlock];
}


///2.
- (void)getDynamicListWithParameters:(NSDictionary *)parameters completedHandler:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock{
    [self POST:kAPIDynamic params:parameters memoryCache:NO diskCache:YES completed:completed isNotReachable:notRBlock];
}




////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark - life
+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static FQAHNetworkingManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[FQAHNetworkingManager alloc] init];
    });
    return manager;
}



////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


@end
