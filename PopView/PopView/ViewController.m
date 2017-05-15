//
//  ViewController.m
//  PopView
//
//  Created by kevin on 16/4/18.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import "ViewController.h"
#import "KMPopView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)clickPop:(UIButton *)sender {
    [[KMPopView popWithTitle:@"Title" text:@"test" sureBtn:@"Sure" cancel:@"Cancel" block:^(NSInteger index) {
        if (index == 0) {//sure
            
        }
        else if (index == 1)//cancel
        {
            
        }
        
    } canTapCancel:YES] show];//canTapCancel:点击半透明区域，pop消失
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
