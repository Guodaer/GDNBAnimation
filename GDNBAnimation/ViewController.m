//
//  ViewController.m
//  GDNBAnimation
//
//  Created by xiaoyu on 16/3/25.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "ViewController.h"
#import "GDAnimationModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setTitle:@"hello" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(hello) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)hello {
    
    [[GDAnimationModel shareInstance] CreateAmazing_AnimationWithSuperView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
