//
//  FHomeController.m
//  fqah
//
//  Created by __无邪_ on 15/11/19.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "FHomeController.h"
#import "UINavigationController+Ghost.h"

@implementation FHomeController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor cyanColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -100, 300, 400)];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    
    NSLog(@"===ssadfadfs");
    NSLog(@"===ssadfadfs");
}

@end
