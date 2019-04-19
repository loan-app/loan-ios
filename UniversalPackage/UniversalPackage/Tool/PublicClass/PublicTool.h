//
//  PublicTool.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicTool : NSObject

//给View划线
+ (void)addLineWithView:(UIView *)view beginPoint:(CGPoint)beginPoint andEndPoint:(CGPoint)endPoint;

+ (void)addLineWithView:(UIView *)view beginPoint:(CGPoint)beginPoint andEndPoint:(CGPoint)endPoint lineColor:(UIColor *)clolor lineHeight:(CGFloat)height;

@end
