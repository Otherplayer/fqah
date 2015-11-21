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
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadDynamic)];
    [view addGestureRecognizer:tapGesture];
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 

- (void)loadDynamic{
    NSMutableDictionary *paramsDictionary = [[NSMutableDictionary alloc] init];
    
    [paramsDictionary setObject:@"112478" forKey:@"d_uid"];
    [paramsDictionary setObject:@"1" forKey:@"page"];
    [paramsDictionary setObject:@(12) forKey:@"size"];
    [paramsDictionary setObject:@"4C648A69-E29D-4465-8677-3B9D90178333" forKey:@"app_id"];
    [paramsDictionary setObject:@"红演圈" forKey:@"app_name"];
    [paramsDictionary setObject:@"ios" forKey:@"app_os"];
    [paramsDictionary setObject:@"8.4" forKey:@"app_os_ver"];
    [paramsDictionary setObject:@"7f891ce8b443674fc1dc70dd8a093496" forKey:@"app_token"];
    [paramsDictionary setObject:@"iPhone Simulator" forKey:@"app_type"];
    [paramsDictionary setObject:@"1.24" forKey:@"app_ver"];
    [paramsDictionary setObject:@"112478" forKey:@"uid"];
    [paramsDictionary setObject:@"" forKey:@"app_umeng"];
    [paramsDictionary setObject:@"4C648A69-E29D-4465-8677-3B9D90178333" forKey:@"mark"];
    
    [[FQAHNetworkingManager sharedManager] getDynamicListWithParameters:paramsDictionary completedHandler:^(BOOL success, BaseModel *responseData) {
        if (success) {
            NSLog(@"%@",responseData);
        }
    } isNotReachable:^{
        NSLog(@"[Warning]isNotReachable");
    }];
    
}


@end
