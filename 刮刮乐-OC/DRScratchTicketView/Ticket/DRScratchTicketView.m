//
//  DRScratchTicketView.m
//  DRScratchTicketView
//
//  Created by DR_Kun on 2018/7/3.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "DRScratchTicketView.h"
#import "DRScratchView.h"

@interface DRScratchTicketView()<DRScratchViewDelegate>

@end

@implementation DRScratchTicketView {
    DRScratchView *_scratchView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImageView = ({
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guaguale.jpg"]];
            imgView.frame = self.bounds;
            imgView.contentMode = UIViewContentModeScaleToFill;
            imgView;
        });
        [self addSubview:bgImageView];
        UILabel *contentLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:25];
            label.text = @"恭喜你刮中500万";
            label.numberOfLines = 0;
            label;
        });
        UIView *maskView = [UIView new];
        maskView.backgroundColor = [UIColor lightGrayColor];
        CGFloat ratio = self.bounds.size.width / 400.0;

        _scratchView = ({
            DRScratchView *scratch = [[DRScratchView alloc] initWithFrame:CGRectZero contentView:contentLabel maskView:maskView];
            scratch.strokeLineWidth = 25;
            scratch.strokeLineCap = kCALineCapRound;
            scratch.delegate = self;
            scratch.frame = CGRectMake(33 * ratio, 140 *ratio, 337 * ratio, 154 * ratio);
            [self addSubview:scratch];
            scratch;
        });

    }
    return self;
}

#pragma mark --- Delegate

- (void)drScratchView:(DRScratchView *)scratchView didScratchedWithPercent:(CGFloat)percent {
    if (percent >= 0.75) {
        [scratchView showContenetView];
    }
}


@end
