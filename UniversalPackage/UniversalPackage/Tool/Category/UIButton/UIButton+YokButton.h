//
//  UIButton+YokButton.h
//  CameraDemo
//
//  Created by Single_Nobel on 2018/8/1.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YokButton)

/**
 *  扩张边界的大小
 */
@property (nonatomic,assign) CGFloat enlargedEdge;

/**
 *  扩张四个边界的大小
 */
- (void)setEnlargedEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

//快速创建按钮,并设置字体大小,字体颜色,背景色
+ (UIButton *)configureOnNormalFont:(UIFont *)font
                         titleColor:(UIColor *)tColor
                         backGround:(UIColor *)bg
                              title:(NSString *)title
                       cornerRadius:(CGFloat)conner
                         borderWith:(CGFloat)border
                        borderColor:(CGColorRef)borderColor;


@end
