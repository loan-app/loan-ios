//
//  BaseColorMacros.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#ifndef BaseColorMacros_h
#define BaseColorMacros_h


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kWhiteColor [UIColor whiteColor]
#define kclearColor [UIColor clearColor]

/** 色值
 */
#define kTableViewColor [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]
#define kRegisterBlueColor [UIColor colorWithRed:0.41 green:0.60 blue:0.87 alpha:1.00]
#define kContactSelectColor [UIColor colorWithRed:0.44 green:0.44 blue:0.44 alpha:1.00]

#define KtabBarSeletecdColor [UIColor colorWithHexString:@"#EB0000"]
#define KtabBarNomalColor [UIColor colorWithHexString:@"#333333"]
#define fontColor [UIColor colorWithHexString:@"#333333"]
#define kCBCBCColor [UIColor colorWithHexString:@"#CBCBCB"]
#define LoginfontColor [UIColor colorWithHexString:@"#666666"]
#define kd8d8Color [UIColor colorWithHexString:@"#D8D8D8"]
#define LoginbtnColor [UIColor colorWithHexString:@"#EB0000"]
#define btnborderColor [UIColor colorWithHexString:@"#999999"]
#define K999Color [UIColor colorWithHexString:@"#999999"]
#define k333Color [UIColor colorWithHexString:@"#333333"]
#define kFFFColor [UIColor colorWithHexString:@"#FFFFFF"]
#define kF5F5F5Color [UIColor colorWithHexString:@"#F5F5F5"]
#define k5C90FF [UIColor colorWithHexString:@"#5C90FF"]
#define kLineColor [UIColor colorWithHexString:@"#ededed"]
#define kF5C982Color [UIColor colorWithHexString:@"#F5C982"]
#define k7ED321 [UIColor colorWithHexString:@"#7ED321"]
#define kC4C4C4Color [UIColor colorWithHexString:@"#C4C4C4"]
#define ksixsixColor [UIColor colorWithHexString:@"#666666"]
#define k828282Color [UIColor colorWithHexString:@"#828282"]



#define k595Color [UIColor colorWithHexString:@"#595CD1"] //兔子



#define kededColor [UIColor colorWithHexString:@"#EDEDED"]
#define k518Color [UIColor colorWithHexString:@"#5182E4"]
#define kea3Color [UIColor colorWithHexString:@"#EA3333"]
#define kefefefColor [UIColor colorWithHexString:@"#EFEFEF"]
#define kblackColor [UIColor colorWithHexString:@"#333333"]
#define knineNineColor [UIColor colorWithHexString:@"#999999"]
#define kbrownisRedColor [UIColor colorWithHexString:@"#F56923"]
#define kyellowColor [UIColor colorWithHexString:@"#FFDB45"]
#define kyellowShadowColor [UIColor colorWithHexString:@"#EAC421"]
#define kcbcbColor [UIColor colorWithHexString:@"#CBCBCB"]
#define kMubHUDColor [UIColor colorWithHexString:@"#61c1bd"]
#define kredError [UIColor colorWithHexString:@"#F54040"]
#define kf2f2Color [UIColor colorWithHexString:@"#F2F2F2"]
#define kfour8Color [UIColor colorWithHexString:@"#484848"]
#define kf5d145Color [UIColor colorWithHexString:@"#F5D154"]


#endif /* BaseColorMacros_h */
