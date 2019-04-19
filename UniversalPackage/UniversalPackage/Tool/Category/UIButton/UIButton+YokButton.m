//
//  UIButton+YokButton.m
//  CameraDemo
//
//  Created by Single_Nobel on 2018/8/1.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "UIButton+YokButton.h"
#import <objc/runtime.h>

@implementation UIButton (YokButton)

static char topEdgeKey;
static char rightEdgeKey;
static char bottomEdgeKey;
static char leftEdgeKey;
/**
 *扩展边界
 */

- (void)setEnlargedEdge:(CGFloat)enlargedEdge {
    [self setEnlargedEdgeWithTop:enlargedEdge right:enlargedEdge bottom:enlargedEdge left:enlargedEdge];
}
- (CGFloat)enlargedEdge {
    return [(NSNumber *)objc_getAssociatedObject(self, &topEdgeKey) floatValue];
}

- (void)setEnlargedEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topEdgeKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rightEdgeKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bottomEdgeKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &leftEdgeKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber *topEdge = objc_getAssociatedObject(self, &topEdgeKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightEdgeKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomEdgeKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftEdgeKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        CGRect enlargedRect = CGRectMake(self.bounds.origin.x - leftEdge.floatValue, self.bounds.origin.y - topEdge.floatValue, self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue, self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
        return enlargedRect;
    }else {
        return self.bounds;
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden) {
        return nil;
    }
    
    CGRect enlargedRect = [self enlargedRect];
    return CGRectContainsPoint(enlargedRect, point) ? self:nil;
}
//快速创建按钮
+ (UIButton *)configureOnNormalFont:(UIFont *)font
                         titleColor:(UIColor *)tColor
                         backGround:(UIColor *)bg
                              title:(NSString *)title
                       cornerRadius:(CGFloat)conner
                         borderWith:(CGFloat)border
                        borderColor:(CGColorRef)borderColor; {
    title = title ? title : @"button";
    font  = font  ? font  : Font(14);
    tColor = tColor ? tColor : kblackColor;
    bg =  bg ? bg : kWhiteColor;
    conner = conner ? conner : BntLength(15);
    border = border ? border : 1.0f;
    borderColor = borderColor ? borderColor : kblackColor.CGColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:tColor forState:UIControlStateNormal];
    [button setBackgroundColor:bg];
    [button.layer setCornerRadius:conner];
    [button.layer setMasksToBounds:YES];
    button.layer.borderWidth = border;
    button.layer.borderColor = borderColor;
    button.titleLabel.font = font;
    return button;
}



@end
