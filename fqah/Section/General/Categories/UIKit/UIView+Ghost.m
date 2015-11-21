//
//  UIView+Ghost.m
//  fqah
//
//  Created by __无邪_ on 15/11/15.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "UIView+Ghost.h"

@implementation UIView (Ghost)

- (void)addCornerRadius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}



@end
