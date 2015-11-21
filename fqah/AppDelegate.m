//
//  AppDelegate.m
//  fqah
//
//  Created by __无邪_ on 15/11/15.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "AppDelegate.h"
#import "BASETabBarController.h"
#import "BASENavigationController.h"

#import "FHomeController.h"
#import "FMsgController.h"
#import "FDiscoverController.h"
#import "FSettingController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Register Splite
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"FQAHModel.sqlite"];
    [BaseModel initKeyMapper];
    // Register Network Monitor
    [[FQAHReachability sharedInstance] startMonitoringInternetStates];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    BASETabBarController *tabBarController = [[BASETabBarController alloc] init];
    
    FHomeController     *controllerHome = [[FHomeController alloc] init];
    FSettingController  *controllerSetting = [[FSettingController alloc] init];
    FMsgController      *controllerMsg = [[FMsgController alloc] init];
    FDiscoverController *controllerDiscover = [[FDiscoverController alloc] init];
    BASENavigationController *navCtrlHome = [[BASENavigationController alloc] initWithRootViewController:controllerHome];
    BASENavigationController *navCtrlMsg = [[BASENavigationController alloc] initWithRootViewController:controllerMsg];
    BASENavigationController *navCtrlDiscover = [[BASENavigationController alloc] initWithRootViewController:controllerDiscover];
    BASENavigationController *navCtrlSetting = [[BASENavigationController alloc] initWithRootViewController:controllerSetting];
    UITabBarItem *itemHome = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
    UITabBarItem *itemSetting = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:1];
    UITabBarItem *itemMsg = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1];
    UITabBarItem *itemDiscover = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:1];
    [navCtrlHome setTabBarItem:itemHome];
    [navCtrlMsg setTabBarItem:itemMsg];
    [navCtrlDiscover setTabBarItem:itemDiscover];
    [navCtrlSetting setTabBarItem:itemSetting];
    
    [tabBarController setViewControllers:@[navCtrlHome,navCtrlMsg,navCtrlDiscover,navCtrlSetting]];
    
    
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [MagicalRecord cleanUp];
}

@end
