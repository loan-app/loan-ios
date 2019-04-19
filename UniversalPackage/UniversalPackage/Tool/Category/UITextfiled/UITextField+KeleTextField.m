//
//  UITextField+KeleTextField.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/5.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "UITextField+KeleTextField.h"

#define defaultStr @"请输入";
#define defaultText @"";
#define defaultColor [UIColor lightGrayColor]
#define defaultFont  [UIFont systemFontOfSize:17]

@implementation UITextField (MLTextField)

+ (UITextField *)configFieldWithPlaceholder:(NSString *)placeholder textAlignment:(NSTextAlignment)alignment {
    
    UITextField * textField = [[UITextField alloc] init];
    if (!placeholder) {
        placeholder = defaultStr;
    }
    
    if (!alignment) {
        alignment = NSTextAlignmentCenter;
    }
    
    textField.placeholder = placeholder;
    textField.textAlignment = alignment;
    return textField;
}

//设置正常显示状态
-(void)configAttributedNormalWithTextField:(UITextField*)textField normalColor:(UIColor *)color textFont:(UIFont *)font attributedString:(NSString *)string {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    if (!color) {
        color = kblackColor;
    }
    if (!font) {
        font = Font(kFont);
    }
    attrs[NSFontAttributeName] = font;
    attrs[NSForegroundColorAttributeName] = color;
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    textField.attributedText = attStr;
}


-(void)configAttributedPlaceHolderWithTextField:(UITextField*)textField placeholderColor:(UIColor *)color textFont:(UIFont *)font attributedString:(NSString *)string {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    if (!color) {
        color = btnborderColor;
    }
    if (!font) {
        font = defaultFont;
    }
    if (string == nil) {
        string = @"";
    }
    
    attrs[NSFontAttributeName] = font;
    attrs[NSForegroundColorAttributeName] = color;
    textField.font = font;
    textField.placeholder = string;
}

@end
