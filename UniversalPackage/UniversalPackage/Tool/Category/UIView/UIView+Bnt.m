//
//  UIView+Bnt.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "UIView+Bnt.h"

@implementation UIView (Bnt)

+ (CGFloat)bnt_configureWidth:(CGFloat)width {
    CGFloat w = ((width / 375.000) * [UIScreen mainScreen].bounds.size.width);
    return w;
}


+ (CGFloat)bnt_configureHeight:(CGFloat)height {
    if (kWidth == 812.0) {
        CGFloat H = (height / 667.000 * 667);
        return H;
    }else{
        CGFloat H = (height / 667.000 * [UIScreen mainScreen].bounds.size.height);

        return H;
    }
}

@end
