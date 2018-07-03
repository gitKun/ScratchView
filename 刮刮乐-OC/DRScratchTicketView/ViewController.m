//
//  ViewController.m
//  DRScratchTicketView
//
//  Created by DR_Kun on 2018/7/3.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "ViewController.h"

#import "BeautyViewController.h"
#import "TickViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            TickViewController *tVC = [[TickViewController alloc] init];
            [self.navigationController pushViewController:tVC animated:YES];
        }
            break;
        case 1: {
            BeautyViewController *bVC = [[BeautyViewController alloc] init];
            [self.navigationController pushViewController:bVC animated:YES];

        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
