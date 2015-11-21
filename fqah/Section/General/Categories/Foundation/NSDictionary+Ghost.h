//
//  NSDictionary+Ghost.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Ghost)
- (NSString *)urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)jsonString;
- (NSArray *)transformedUrlParamsArraySignature:(BOOL)isForSignature;
@end
