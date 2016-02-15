//
//  ViewController.m
//  sample
//
//  Created by jhaoheng on 2016/2/15.
//  Copyright © 2016年 max. All rights reserved.
//

#import "ViewController.h"
#import "jb_check.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [jb_check is_jb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
