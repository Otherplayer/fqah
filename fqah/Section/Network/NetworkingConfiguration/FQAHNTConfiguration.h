//
//  FQAHNetworkConfiguration.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#ifndef FQAHNTConfiguration_h
#define FQAHNTConfiguration_h

#define SHOULD_USE_JSONMODEL   /*是否调用JSONModel*/
#import "BaseModel.h"

////////////////////////////////////////
#ifdef DEBUG
#define IS_OFF_LINE
#endif
////////////////////////////////////////


#ifdef IS_OFF_LINE
#define FQAH_API @"https://121"
#else
#define FQAH_API @"https://www"          //线上接口
#endif


static NSTimeInterval kFQAHNetworkTimeoutInterval   = 60;    // 超时时间
static NSTimeInterval kFQAHCacheOutdateTimeSeconds = 300;   // 5分钟的cache过期时间
static NSUInteger     kFQAHCacheCountLimit         = 1000;  // 最多1000条cache
static NSUInteger     kFQAHDiskCacheCapacityLimitM = 500;   // 最大本地缓存容量 500 M

typedef NS_ENUM(NSInteger, FQAHResponseErrCodeType){
    FQAHURLResponseStatusSuccess = 1000,        //请求是否成功只考虑是否成功收到服务器反馈。
    FQAHURLResponseStatusErrorTimeout = 10001,  //请求超时
    FQAHURLResponseStatusErrorNoNetwork = 10002 //除了超时以外的错误都是网络错误。
};


#ifdef SHOULD_USE_JSONMODEL
typedef void (^FQAHRequestCallbackBlock)(BOOL success, BaseModel *responseData);
#else
typedef void (^FQAHRequestCallbackBlock)(BOOL success, id responseData);
#endif
typedef void (^FQAHNetNotReachabilityBlock)();


#endif /* FQAHNetworkConfiguration_h */
