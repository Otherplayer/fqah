//
//  FQAHCache.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FQAHCache : NSObject

+ (instancetype)sharedInstance;

- (NSData *)fetchCachedDataWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams;

- (void)saveCacheWithData:(NSData *)cachedData
                   URLStr:(NSString *)urlStr params:(NSDictionary *)requestParams;

- (void)deleteCacheWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams;



- (NSString *)keyWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams;

- (NSData *)fetchCachedDataWithKey:(NSString *)key;
- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key;
- (void)deleteCacheWithKey:(NSString *)key;
- (void)clean;


@end
