//
//  UIDevice+Ghost.m
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "UIDevice+Ghost.h"
#include <sys/param.h>
#include <sys/mount.h>

@implementation UIDevice (Ghost)
+ (long long) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace/1024;
}

@end
