//
//  AppDelegate.m
//  huanXin222
//
//  Created by wecar on 2017/5/5.
//  Copyright © 2017年 huanXin. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <HyphenateLite/HyphenateLite.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    UIWindow *wind = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [wind makeKeyWindow];
//    ViewController *vie = [[ViewController alloc] init];
////    wind.rootViewController = [[UINavigationController alloc] initWithRootViewController:vie];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vie];
//    wind.rootViewController = nav;
    EMOptions *options = [EMOptions optionsWithAppkey:@"1149170504115045#huanxin222"];
    options.apnsCertName = @"";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
