//
//  UILabel+KeleLabel.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MLLabel)

//创建label
+ (UILabel *)configWithFont:(UIFont *)font TextColor:(UIColor *)color background:(UIColor *)bg title:(NSString *)text;

+(UILabel *)initFrame:(CGRect)frame Aligent:(NSTextAlignment)textAligent Font:(CGFloat)font  Text:(NSString *)text Color:(UIColor *)color;
@end


