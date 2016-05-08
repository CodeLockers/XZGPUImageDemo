//
//  ViewController.m
//  XZGPUImageDemo
//
//  Created by 徐章 on 16/5/8.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import "SingleFilterViewController.h"
#import "FWNashvilleFilter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SingleFilterViewController *viewController = segue.destinationViewController;
    viewController.type = segue.identifier;
    
}

@end
