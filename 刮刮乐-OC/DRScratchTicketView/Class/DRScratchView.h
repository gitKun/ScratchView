//
//  DRScratchView.h
//  DRScratchTicketView
//
//  Created by DR_Kun on 2018/7/3.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRScratchView;

@protocol DRScratchViewDelegate <NSObject>

- (void)drScratchView:(DRScratchView *)scratchView didScratchedWithPercent:(CGFloat)percent;

@end

@interface DRScratchView : UIView

@property (nonatomic, weak) id <DRScratchViewDelegate>delegate;
@property (nonatomic, copy) NSString *strokeLineCap;
@property (nonatomic, assign) CGFloat strokeLineWidth;


- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView maskView:(UIView *)maskView;// NS_DESIGNATED_INITIALIZER;

/**** 显示全部的contentView ***/
- (void)showContenetView;
/**** 重置 ***/
- (void)resetState;

@end
