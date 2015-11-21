//
//  FQAHNetworkingManager.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "FQAHNetworking.h"

@interface FQAHNetworkingManager : FQAHNetworking
+ (instancetype)sharedManager;

/// 获取一级类型列表
- (void)getTopTypesWithParameters:(NSDictionary *)parameters completedHandler:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock;

/// 获取动态
- (void)getDynamicListWithParameters:(NSDictionary *)parameters completedHandler:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock;

@end
