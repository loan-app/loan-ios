//
//  UILabel+KeleLabel.m
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "UILabel+KeleLabel.h"

@implementation UILabel (MLLabel)

+ (UILabel *)configWithFont:(UIFont *)font TextColor:(UIColor *)color background:(UIColor *)bg title:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    if (font == nil) {
        font = Font(14);
    }
    if (bg == nil) {
        bg = kclearColor;
    }
    if (color == nil) {
        color = kblackColor;
    }
    label.font = font;
    label.textColor = color;
    label.backgroundColor = bg;
    label.text = text;
    return label;
}

+(UILabel *)initFrame:(CGRect)frame Aligent:(NSTextAlignment)textAligent Font:(CGFloat)font Text:(NSString *)text Color:(UIColor *)color{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textAlignment =  textAligent;
    label.font = [UIFont systemFontOfSize:font];
    label.text = text;
    label.textColor = color;
    return label;
}
@end
