//
//  FQAHLogger.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FQAHURLResponse.h"

@interface FQAHLogger : NSObject

+ (void)logDebugResponse:(FQAHURLResponse *)response;

+ (void)logDebugOperation:(AFHTTPRequestOperation *)operation;

@end
