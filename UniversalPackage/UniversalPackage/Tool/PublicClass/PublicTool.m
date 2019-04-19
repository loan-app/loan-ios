//
//  PublicTool.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "PublicTool.h"

@implementation PublicTool

+ (void)addLineWithView:(UIView *)view beginPoint:(CGPoint)beginPoint andEndPoint:(CGPoint)endPoint {
    UIBezierPath * ber = [UIBezierPath bezierPath];
    [ber moveToPoint:beginPoint];
    [ber addLineToPoint:endPoint];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.strokeColor = kLineColor.CGColor;
    layer.lineWidth = BntLength(0.8);
    layer.path = ber.CGPath;
    [view.layer addSublayer:layer];
}

+ (void)addLineWithView:(UIView *)view beginPoint:(CGPoint)beginPoint andEndPoint:(CGPoint)endPoint lineColor:(UIColor *)clolor lineHeight:(CGFloat)height {
    UIBezierPath * ber = [UIBezierPath bezierPath];
    [ber moveToPoint:beginPoint];
    [ber addLineToPoint:endPoint];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.strokeColor = clolor.CGColor;
    layer.lineWidth = height;
    layer.path = ber.CGPath;
    [view.layer addSublayer:layer];
}

@end
