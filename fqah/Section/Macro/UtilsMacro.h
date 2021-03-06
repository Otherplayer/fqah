//
//  UtilsMacro.h
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h



////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

static inline NSString *FQAHStringFromDate(NSString *dateFormat, NSDate *date) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define IS_IPHONE4      ([UIScreen mainScreen].bounds.size.height == 480.0f)
#define IS_IPHONE5      ([UIScreen mainScreen].bounds.size.height == 568.0f)
#define IS_IPHONE6      ([UIScreen mainScreen].bounds.size.height == 667.0f)//375w
#define IS_IPHONE6_PLUS ([UIScreen mainScreen].bounds.size.height == 736.0f)//414w

#define IS_IOS7    ((([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)&&([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0))? (YES):(NO))
#define IS_IOS8    ((([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)&&([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0))? (YES):(NO))
#define IS_IOS9    ((([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)&&([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0))? (YES):(NO))

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#define WS(weakSelf)          __weak __typeof(&*self)weakSelf = self;

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

// 国际化
#define i18n_Text(key)         NSLocalizedString(key, nil)
#define FQAHString(key)        NSLocalizedString(key, @"")

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

//格式化log
//#ifdef DEBUG
//#define FQAHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//#define FQAHLog(...)
//#endif

#ifdef DEBUG
#define NSLog(format, ...) do { \
fprintf(stderr, "<%s : %d> %s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__); \
(NSLog)((format), ##__VA_ARGS__); \
fprintf(stderr, \
"\n" \
);} while (0)
#else
#define NSLog(...)
#endif

#endif /* UtilsMacro_h */
