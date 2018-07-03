//
//  BeautyViewController.m
//  DRScratchTicketView
//
//  Created by DR_Kun on 2018/7/3.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "BeautyViewController.h"
#import "DRScratchView.h"

@interface BeautyViewController ()

@property (nonatomic, strong) UIImageView *aboveImageView;
@property (nonatomic, strong) UIImageView *underImageView;
@property (nonatomic, strong) DRScratchView *beautyView;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation BeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.aboveImageView = [UIImageView new];
    self.underImageView = [UIImageView new];
    self.beautyView = [[DRScratchView alloc] initWithFrame:CGRectZero contentView:self.underImageView maskView:self.aboveImageView];
    CGFloat margin = 20.0;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - margin * 2;
    CGFloat height = width * (480/320.0);
    self.beautyView.frame = CGRectMake(margin, 100, width, height);
    [self.view addSubview:self.beautyView];
    [self reloadData];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextBeauty)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}


- (void)nextBeauty {
    self.currentIndex += 1;
    [self reloadData];
}

- (void)reloadData {
    NSInteger index = self.currentIndex % 16 + 1;
    NSString *aboveName = [NSString stringWithFormat:@"g%@_up",@(index)];
    NSString *underName = [NSString stringWithFormat:@"g%@_back",@(index)];
    if (index >= 8) {
        aboveName = [aboveName stringByAppendingString:@".jpg"];
        underName = [underName stringByAppendingString:@".jpg"];
    }
    if (self.currentIndex % 16 == 0) {
        self.currentIndex = 0;
    }
    self.aboveImageView.image = [UIImage imageNamed:aboveName];
    self.underImageView.image = [UIImage imageNamed:underName];
    [self.beautyView resetState];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
