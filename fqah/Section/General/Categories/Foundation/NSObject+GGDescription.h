//
//  NSObject+GGDescription.h
//  GGArchiver
//
//  Created by __无邪_ on 15/11/12.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GGDescription)

// 返回self的所有对象名称
+ (NSArray *)propertyOfSelf;
// 详细
- (NSString *)descriptionDetail;


@end
