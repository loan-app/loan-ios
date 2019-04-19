//
//  UIFont+FitSize.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "UIFont+FitSize.h"

@implementation UIFont (FitSize)

+ (UIFont *)bnt_configure:(CGFloat)font
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    if(w < 375)
    {
        return [UIFont systemFontOfSize:font];
    }else{
        return [UIFont systemFontOfSize:BntAltitude(font)];
    }
}

@end
