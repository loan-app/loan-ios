//
//  UITextField+KeleTextField.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/5.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MLTextField)

+ (UITextField *)configFieldWithPlaceholder:(NSString *)placeholder textAlignment:(NSTextAlignment)alignment;

//设置占位状态
-(void)configAttributedPlaceHolderWithTextField:(UITextField*)textField placeholderColor:(UIColor *)color textFont:(UIFont *)font attributedString:(NSString *)string;

//设置正常显示状态
-(void)configAttributedNormalWithTextField:(UITextField*)textField normalColor:(UIColor *)color textFont:(UIFont *)font attributedString:(NSString *)string;


@end
