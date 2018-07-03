//
//  TickViewController.m
//  DRScratchTicketView
//
//  Created by DR_Kun on 2018/7/3.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "TickViewController.h"
#import "DRScratchTicketView.h"

@interface TickViewController ()

@end

@implementation TickViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat margin = 20.0;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - margin * 2;
    CGFloat height = width * (300.0 / 400.0);
    DRScratchTicketView *tickView = [[DRScratchTicketView alloc] initWithFrame:CGRectMake(margin, 100, width, height)];
    [self.view addSubview:tickView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
