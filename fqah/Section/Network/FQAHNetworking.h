//
//  FQAHNetworking.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "FQAHNTConfiguration.h"
#import "FQAHReachability.h"
#import "BaseModel.h"

@interface FQAHNetworking : AFHTTPRequestOperationManager
//*(+ (instancetype)sharedNetwork;)*//

/// post 请求
- (void)POST:(NSString *)URLString params:(id)parameters memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completed:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock;

/// post 上传图片 (/** 数组images里面数据为dictionary{kIMGKey:image} **/)
- (void)POST:(NSString *)URLString params:(id)parameters images:(NSArray *)images imageSConfig:(NSString *)serviceName completed:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock;

/// get 请求
- (void)GET:(NSString *)URLString params:(id)parameters memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completed:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock;

@end
