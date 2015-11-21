//
//  NSURLRequest+Ghost.m
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "NSURLRequest+Ghost.h"
#import <objc/runtime.h>

static void *GGNetworkingRequestParams;

@implementation NSURLRequest (Ghost)
- (void)setRequestParams:(NSDictionary *)requestParams{
    objc_setAssociatedObject(self, &GGNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams{
    return objc_getAssociatedObject(self, &GGNetworkingRequestParams);
}

@end
