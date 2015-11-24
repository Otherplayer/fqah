//
//  NSObject+GGDescription.m
//  GGArchiver
//
//  Created by __无邪_ on 15/11/12.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "NSObject+GGDescription.h"
#import <objc/runtime.h>

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation NSObject (GGDescription)

// OBJC_EXPORT Ivar *class_copyIvarList(Class cls, unsigned int *outCount)
// Ivar：成员属性的意思
// 第一个参数：表示获取哪个类中的成员属性
// 第二个参数：表示这个类有多少成员属性，传入一个Int变量地址，会自动给这个变量赋值
// 返回值Ivar *：指的是一个ivar数组，会把所有成员属性放在一个数组中，通过返回的数组就能全部获取到

// 返回self的所有对象名称
+ (NSArray *)propertyOfSelf{
    unsigned int count;
    // 1. 获得类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    NSMutableArray *properNames =[NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        // 2.获得成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 3.除去下划线，从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        [properNames addObject:key];
    }
    return [properNames copy];
}

- (NSString *)descriptionDetail{
    NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"\n"];
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        SEL getSel = NSSelectorFromString(propertyName);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *propertyNameString = [NSString stringWithFormat:@"%@ - %@\n",propertyName,[self performSelector:getSel]];
#pragma clang diagnostic pop
        [descriptionString appendString:propertyNameString];
    }
    return [descriptionString copy];
}

@end
