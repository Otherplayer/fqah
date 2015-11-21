//
//  NSFileManager+Ghost.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Ghost)
+ (long long)fileSizeAtPath:(NSString *)filePath;
@end
