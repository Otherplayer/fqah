//
//  BaseModel.m
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+ (void)initKeyMapper
{
    [JSONModel setGlobalKeyMapper:[
                                   [JSONKeyMapper alloc] initWithDictionary:@{
                                                                              @"description" : @"desc",
                                                                              }
                                   ]
     ];
}
@end
