//
//  DRScratchView.m
//  DRScratchTicketView
//
//  Created by DR_Kun on 2018/7/3.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "DRScratchView.h"

@interface DRScratchView ()

@property (nonatomic, strong) UIView *scratchContentView;
@property (nonatomic, strong) UIView *scratchMaskView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIBezierPath *maskPath;

@end

@implementation DRScratchView

#pragma mark --- Public

- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView maskView:(UIView *)maskView {
    self = [super initWithFrame:frame];
    if (self) {
        self.scratchContentView = contentView;
        self.scratchMaskView = maskView;
        [self addSubview:maskView];
        [self addSubview:contentView];
        self.maskLayer = ({
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.strokeColor = [UIColor redColor].CGColor;
            layer.lineWidth = 20;
            layer.lineCap = kCALineCapRound;
            layer;
        });
        self.maskPath = [UIBezierPath bezierPath];
        self.scratchContentView.layer.mask = self.maskLayer;
    }
    return self;
}

/**** 显示全部的contentView ***/
- (void)showContenetView {
    self.scratchContentView.layer.mask = nil;
}
/**** 重置 ***/
- (void)resetState {
    [self.maskPath removeAllPoints];
    self.maskLayer.path = nil;
    self.scratchContentView.layer.mask = self.maskLayer;
}

#pragma mark --- overwrite

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scratchContentView.frame = self.bounds;
    self.scratchMaskView.frame = self.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];
    if (touch) {
        CGPoint point = [touch locationInView:self.scratchContentView];
        [self.maskPath moveToPoint:point];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];
    if (touch) {
        CGPoint point = [touch locationInView:self.scratchContentView];
        [self.maskPath addLineToPoint:point];
        [self.maskPath moveToPoint:point];
        self.maskLayer.path = self.maskPath.CGPath;
        [self updateScratchScopePercent];
    }
}

#pragma mark --- setter

- (void)setStrokeLineCap:(NSString *)strokeLineCap {
    self.maskLayer.lineCap = strokeLineCap;
}

- (void)setStrokeLineWidth:(CGFloat)strokeLineWidth {
    self.maskLayer.lineWidth = strokeLineWidth;
}

#pragma mark --- pravite

- (void)updateScratchScopePercent {
    UIImage *image = [self getImageFromContentView];
    CGFloat percent = 1 - [self getAlphaPixelPercent:image];
    percent = MAX(0, MIN(1, percent));
    if (self.delegate) {
        [self.delegate drScratchView:self didScratchedWithPercent:percent];
    }
}

- (UIImage *)getImageFromContentView {
    CGSize size = self.scratchContentView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.scratchContentView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (CGFloat)getAlphaPixelPercent:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat bitmapByteCount = width * height;


    unsigned char* pixeDeta = malloc(bitmapByteCount);
    if (pixeDeta == NULL)  {
        fprintf (stderr, "Memory not allocated!");
        return 0;
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(pixeDeta, width, height, 8, width, colorSpace, kCGImageAlphaOnly);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextClearRect(context, rect);
    CGContextDrawImage(context, rect, image.CGImage);

    //计算透明度
    NSUInteger alpgaPixeCount = 0;
    for (NSUInteger x = 0; x < (NSUInteger)width; x++) {
        for (NSUInteger y = 0; y < (NSUInteger)height; y++) {
            int alpha = pixeDeta[y * (NSUInteger)width + x];
            if (alpha == 0) {
                alpgaPixeCount++;
            }
        }
    }
    //释放内存
    free(pixeDeta);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    CGFloat percent = alpgaPixeCount * 1.0 / bitmapByteCount;
    printf("percent = %.3f ____# \n",percent);
    return percent;
}




@end
