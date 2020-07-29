//
//  AppDelegate.m
//  RNiOSDemo
//
//  Created by zyx on 2020/7/26.
//  Copyright © 2020 zyx. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = nav;
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
