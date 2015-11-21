//
//  UINavigationController+Ghost.m
//  fqah
//
//  Created by __无邪_ on 15/11/19.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "UINavigationController+Ghost.h"

@implementation UINavigationController (Ghost)
- (void)applyApprenceWithBarTintColor:(UIColor *)tintColor fontColor:(UIColor *)fontColor{
    
    UINavigationBar *navigationBar = self.navigationBar;
    self.navigationBar.alpha = 0.5;
//        NSShadow *shadow = [[NSShadow alloc] init];
//        shadow.shadowBlurRadius = 5;
//        shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//        shadow.shadowOffset = CGSizeMake(1.2, 1.2);
    
    [navigationBar setTitleTextAttributes:@{
                                            NSFontAttributeName : [UIFont systemFontOfSize:17.f],
                                            NSForegroundColorAttributeName : fontColor,
                                            //                                            NSShadowAttributeName: shadow,
                                            //                                            NSVerticalGlyphFormAttributeName:@1
                                            }];
    [navigationBar setTintColor:fontColor];    //设置字体颜色
    [navigationBar setBarTintColor:tintColor]; //设置背景色
    [navigationBar setTranslucent:YES];        //开透明
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    iOS7之后由于navigationBar.translucent默认是YES，坐标零点默认在（0，0）点  当不透明的时候，零点坐标在（0，64）；如果你想设置成透明的，而且还要零点从（0，64）开始，那就添加：self.edgesForExtendedLayout = UIRectEdgeNone;
}
@end
