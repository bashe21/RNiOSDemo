//
//  ViewController.m
//  RNiOSDemo
//
//  Created by zyx on 2020/7/26.
//  Copyright © 2020 zyx. All rights reserved.
//

#import "ViewController.h"
#import "RNPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *btn = [[UIButton alloc] init];
//    btn.frame = CGRectMake(100, 200, 60, 40);
//    [btn setTitle:@"pnpage" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(RNPageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

- (IBAction)RNPageBtnClicked:(UIButton *)sender {
    RNPageViewController *rnPage = [[RNPageViewController alloc] init];
    [self.navigationController pushViewController:rnPage animated:YES];
}

@end
