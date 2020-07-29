//
//  RNPageViewController.m
//  RNiOSDemo
//
//  Created by zyx on 2020/7/27.
//  Copyright © 2020 zyx. All rights reserved.
//

#import "RNPageViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>
//#import <React/RCTEventEmitter.h>

@interface RNPageViewController ()

@end

@implementation RNPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRCTRootView];
}

- (void)initRCTRootView {
    NSURL *jsCodeLocation;
    // 手动拼接jsCodeLocation 用于开发环境
    //jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    // release 后从包中读取名为main的静态js bundle
    //jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
    // 通过RCTBundleURLProvider生成，用于开发环境
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];

    // 这个"APP"名字一定要和我们在index.js中注册的名字保持一致
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"RNiOSDemo" initialProperties:nil launchOptions:nil];
    self.view = rootView;
}
@end
