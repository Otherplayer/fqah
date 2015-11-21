//
//  NSMutableString+Ghost.m
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "NSMutableString+Ghost.h"
#import "NSObject+Ghost.h"

@implementation NSMutableString (Ghost)
- (void)appendURLRequest:(NSURLRequest *)request{
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] defaultValue:@"\t\t\t\tN/A"]];
}

@end
